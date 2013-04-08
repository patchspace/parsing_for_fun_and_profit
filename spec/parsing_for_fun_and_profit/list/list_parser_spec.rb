require 'spec_helper'

require 'parsing_for_fun_and_profit/list/list_parser'

module ParsingForFunAndProfit
  module List
    describe ListParser do
      subject(:parser) { ListParser.new }

      def conversion_method_for_parse_as
        :to_list
      end

      # rule not_a_list
      #   "" {
      #     def to_list
      #       :nothing
      #     end
      #   }
      # end
      example do
        pending
        expect("").to parse_as(:nothing)
      end

      # rule list
      #   "[]" {
      #     def to_list
      #       [ ]
      #     end
      #   }
      # end
      #
      # rule maybe_a_list
      #   not_a_list
      #   /
      #   list
      # end
      example do
        pending
        expect("[]").to parse_as([])
      end

      # 1:
      # rule list
      #   "[" list_item "]" {
      #     def to_list
      #       [ list_item.to_list ]
      #     end
      #   }
      # end
      #
      # rule list_item
      #   "a" {
      #     def to_list
      #       :a
      #     end
      #   }
      # end
      #
      # 2:
      # class ::Treetop::Runtime::SyntaxNode
      #   def to_list
      #     nil
      #   end
      # end
      #
      # rule list
      #   "[" item:list_item? "]" {
      #     def to_list
      #       [ item.to_list ].compact
      #     end
      #   }
      # end
      #
      # rule list_item
      #   "a" {
      #     def to_list
      #       :a
      #     end
      #   }
      # end
      example do
        pending
        expect("[a]").to parse_as([:a])
      end

      # rule list_item
      #   [a-z] {
      #     def to_list
      #       text_value.to_sym
      #     end
      #   }
      # end
      example do
        pending
        expect("[z]").to parse_as([:z])
      end

      # rule list
      #   "[" blank item:list_item? blank "]" {
      #     def to_list
      #       [ item.to_list ].compact
      #     end
      #   }
      # end
      #
      # rule blank
      #   " "*
      # end
      example do
        pending
        expect("[ a ]").to parse_as([:a])
      end

      # 1:
      # rule list_items
      #   first:list_item rest:("," next:list_item)* {
      #     def to_list
      #       [first.to_list] + rest.elements.map { |element| element.next.to_list }
      #     end
      #   }
      # end
      #
      # 2:
      # rule list
      #   "[" blank items:list_items? blank "]" {
      #     def to_list
      #       items.to_list
      #     end
      #   }
      # end
      #
      # 3:
      # class ::Treetop::Runtime::SyntaxNode
      #   def to_list
      #     [ ]
      #   end
      # end
      example do
        pending
        expect("[a,b,c]").to parse_as([:a, :b, :c])
      end

      # rule list_items
      #   first:list_item rest:(blank "," blank next:list_item)* {
      #     def to_list
      #       [first.to_list] + rest.elements.map { |element| element.next.to_list }
      #     end
      #   }
      # end
      example do
        pending
        expect("[ a , b , c ]").to parse_as([:a, :b, :c])
      end

      example do
        pending
        expect("[   ]").to parse_as([])
      end

      # rule symbol
      #   [a-z] {
      #     def to_list
      #       text_value.to_sym
      #     end
      #   }
      # end
      #
      # rule list_item
      #   symbol
      #   /
      #   list
      # end
      example do
        pending
        expect("[ [] ]").to parse_as([[]])
      end

      example do
        pending
        expect("[ a, [] ]").to parse_as([ :a, [] ])
      end

      example do
        pending
        expect("[ [], [] ]").to parse_as([[], []])
      end

      example do
        pending
        expect("[a, [ b, c, [] ], [d], e]").to parse_as([:a, [ :b, :c, [] ], [:d], :e])
      end
    end
  end
end