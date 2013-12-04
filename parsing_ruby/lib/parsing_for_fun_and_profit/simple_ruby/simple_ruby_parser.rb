require 'facets/array'
require 'treetop'

Treetop.load(File.dirname(__FILE__) + '/simple_ruby')

module ParsingForFunAndProfit
  module SimpleRuby
    module SimpleRuby
      # A common trick I use is to re-open Treetop's SyntaxNode base class
      # to add default generic behaviour to any node we get back, which given
      # the bizarre trees you can get back from Treetop is very useful
      class ::Treetop::Runtime::SyntaxNode
        def to_ast
          return if elements.nil?
          elements.inject([ ]) { |mem, element| mem << element.to_ast }.compact
        end

        def ast_elements
          return [ ] if elements.nil?
          our_elements = elements.map { |element| element.to_ast if element }
          flatten_elements(our_elements)
        end

        # This is the key method - it's an "intelligent flatten" that turns eg:
        #   [ [ [ [:node, "foo"], [:node, "foo"] ] ] ]
        # into:
        #   [ [:node, "foo"], [:node, "foo"] ]
        #
        # This is vital for testing as otherwise Treetop's semantically
        # worthless intermediate nodes make comparing ASTs really fragile.
        # It has to be recursive as we never know how many useless nodes
        # are wrapping the ones we care about.
        def flatten_elements(elements)
          elements.inject([ ]) { |flattened, element|
            if needs_flattening?(element)
              flattened.concat(flatten_elements(element))
            else
              flattened << element
            end
          }.compact
        end

        def generate_html(builder)
          return if elements.nil?

          elements.each do |element|
            element.generate_html(builder)
          end
        end

        private

        def needs_flattening?(element)
          element.is_a?(Array) && !element.first.is_a?(Symbol)
        end
      end

      # Please forgive my template methods
      class LineGroupNode < Treetop::Runtime::SyntaxNode
        def to_ast
          [ node_type, ast_elements ]
        end

        def generate_html(builder)
          builder.linegroup(html_linegroup_class) do |b|
            super(b)
          end
        end
      end

      class Program < LineGroupNode
        def node_type
          :program
        end

        def html_linegroup_class
          "source"
        end
      end

      class MethodDefinitionNode < LineGroupNode
        def node_type
          :methdef
        end

        def html_linegroup_class
          "method"
        end
      end

      module TextNode
        def to_ast
          [ text_node_type, text_value ]
        end

        def generate_html(builder)
          builder.text_node(text_node_type, text_value)
        end
      end

      class NewlineNode < Treetop::Runtime::SyntaxNode
        def to_ast
          [ :newline, text_value ]
        end

        def generate_html(builder)
          builder.line_ended
        end
      end
    end
  end
end