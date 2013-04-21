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

      # rule list
      #   "[" blank "]" {
      #     def to_list
      #       [ ]
      #     end
      #   }
      # end
      #
      # rule blank
      #   " "*
      # end
      example do
        pending
        expect("[   ]").to parse_as([])
      end

      # rule list
      #   empty_list
      #   /
      #   list_with_elements
      # end
      #
      # rule empty_list
      #   "[" blank "]" {
      #     def to_list
      #       [ ]
      #     end
      #   }
      # end
      #
      # rule list_with_elements
      #   "[" list_item "]" {
      #     def to_list
      #       [ list_item.list_value ]
      #     end
      #   }
      # end
      #
      # rule list_item
      #   "a" {
      #     def list_value
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

      # rule list_with_elements
      #   "[" blank list_item blank "]" {
      #     def to_list
      #       [ list_item.list_value ]
      #     end
      #   }
      # end
      example do
        pending
        expect("[ a ]").to parse_as([:a])
      end

      # rule list_with_elements
      #   "[" blank list_items blank "]" {
      #     def to_list
      #       list_items.to_list
      #     end
      #   }
      # end
      #
      # rule list_items
      #   first:list_item rest:("," next:list_item)* {
      #     def to_list
      #       [first.list_value] + rest.elements.map { |element| element.next.list_value }
      #     end
      #   }
      # end
      example do
        pending
        expect("[a,b,c]").to parse_as([:a, :b, :c])
      end

      # rule list_items
      #   first:list_item rest:(blank "," blank next:list_item)* {
      #     def to_list
      #       [first.list_value] + rest.elements.map { |element| element.next.list_value }
      #     end
      #   }
      # end
      example do
        pending
        expect("[ a , b , c ]").to parse_as([:a, :b, :c])
      end

      # rule symbol
      #   [a-z] {
      #     def list_value
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
      #
      # rule list
      #   (
      #     empty_list
      #     /
      #     list_with_elements
      #   ) {
      #     def list_value
      #       to_list
      #     end
      #   }
      # end
      example do
        pending
        expect("[ [] ]").to parse_as([[]])
      end

      example do
        pending
        expect("[ a, [] ]").to parse_as([:a, []])
      end

      example do
        pending
        expect("[ [], [] ]").to parse_as([[], []])
      end

      example do
        pending
        expect("[a, [ b, c, [] ], [d], e]").to parse_as(
          [:a, [ :b, :c, [] ], [:d], :e]
        )
      end
    end
  end
end