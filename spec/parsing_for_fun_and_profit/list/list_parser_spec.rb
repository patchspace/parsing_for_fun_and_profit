require 'spec_helper'

require 'parsing_for_fun_and_profit/list/list_parser'

module ParsingForFunAndProfit
  module List
    describe ListParser, focus: true, full_backtrace: true do
      subject(:parser) { ListParser.new }

      def conversion_method_for_parse_as
        :to_list
      end

      example do
        expect("").to parse_as(:nothing)
      end

      example do
        expect("[]").to parse_as([])
      end

      example do
        expect("[   ]").to parse_as([])
      end

      example do
        expect("[a]").to parse_as([:a])
      end

      example do
        expect("[ a ]").to parse_as([:a])
      end

      example do
        expect("[a,b]").to parse_as([:a, :b])
      end

      example do
        expect("[ a , b]").to parse_as([:a, :b])
      end

      example do
        expect("[a, b, c]").to parse_as([:a, :b, :c])
      end

      example do
        expect("[ [] ]").to parse_as([[]])
      end

      example do
        expect("[ a, [] ]").to parse_as([ :a, [] ])
      end

      example do
        expect("[ [], [] ]").to parse_as([[], []])
      end

      example do
        expect("[a, [ b, c, [] ], [d], e]").to parse_as([:a, [ :b, :c, [] ], [:d], :e])
      end
    end
  end
end