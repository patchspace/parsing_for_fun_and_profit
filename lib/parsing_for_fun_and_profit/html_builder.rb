require 'builder'

# A builder I hacked together purely for the talk demo
# (it doesn't have tests of its own, only the grammar does)

# Mostly this just delegates to a Builder (as in the gem) object
# via the `text_node` method, but it actually has two phases:
#
#   * When we see a text node, we add it to the current line
#     (if we don't have a buffer for the current line, we make a new one)
#
#   * When we see a newline node, we write the current line buffer
#     to the overall HTML document buffer
#
# We also have a `linegroup` feature. This is how the method highlighting
# works when you hover over a method name. If we had class definitions too
# (probably not that hard now), it would be easy to have them highlighted
# when you hover over the class name.

module ParsingForFunAndProfit
  class HTMLBuilder
    def initialize
      @buffer = ""
      @builder = Builder::XmlMarkup.new(target: @buffer)
      clear_line
    end

    def linegroup(name)
      @builder.div(class: "linegroup #{name}") do |b|
        yield self
      end
    end

    def text_node(type, content)
      line.span(class: type) do
        line << content
      end
    end

    def line_ended
      @builder.div(class: "line") do
        @builder.pre do
          @builder << @line_buffer
        end
      end

      clear_line
    end

    def to_html
      @buffer
    end

    private

    def line
      if @line.nil?
        @line_buffer = ""
        @line = Builder::XmlMarkup.new(target: @line_buffer)
      end
      @line
    end

    def clear_line
      @line = nil
      @line_buffer = ""
    end
  end
end