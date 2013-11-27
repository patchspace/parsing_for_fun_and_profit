require 'spec_helper'
require 'parsing_for_fun_and_profit/arithmetic/arithmetic_parser'

# By and large you can implement this parser by commenting out or removing
# each `pending` line in turn, and copying in the rules. I haven't put the
# rules for numbers in here, they're almost the same as the regex form.
# Some of the rules need refactoring after adding in.

module ParsingForFunAndProfit
  module Arithmetic
    describe ArithmeticParser do
      subject(:parser) { ArithmeticParser.new }

      context "numbers" do
        example do
          pending
          expect(parser.parse("1").evaluate).to be == 1
        end

        example do
          pending
          expect(parser.parse("1234567890").evaluate).to be == 1234567890
        end

        example do
          pending
          expect(parser.parse("-123").evaluate).to be == -123
        end
      end

      context "multiplication" do
        # rule multitive
        #   head:number
        #   tail:(
        #     space operator:multiplicative_op
        #     space operand:number)* <BinaryOperation>
        # end

        # rule multiplicative_op
        #   '*' {
        #     def apply(a, b)
        #       a * b
        #     end
        #   }
        # end

        # rule space
        #   ' '*
        # end

        example do
          pending
          expect(parser.parse("2 * 3").evaluate).to be == 6
        end
        example do
          pending
          expect(parser.parse("2 * 3 * 4").evaluate).to be == 24
        end
      end

      context "addition" do
        # rule additive
        #   head:number
        #   tail:(
        #     space operator:additive_op
        #     space operand:number)* <BinaryOperation>
        # end

        # rule additive_op
        #   '+' {
        #     def apply(a, b)
        #       a + b
        #     end
        #   }
        # end

        # It's supposed to break multiplication - refactor

        example do
          pending
          expect(parser.parse("2 + 3").evaluate).to be == 5
        end
        example do
          pending
          expect(parser.parse("2 + 3 + 4").evaluate).to be == 9
        end
      end

      context "combined" do
        example do
          pending
          expect(parser.parse("2 * 3 + 4").evaluate).to be == 10
        end
      end

      context "precedence" do
        example do
          pending
          expect(parser.parse("2 + 3 * 4 + 5").evaluate).to be == 19
        end

        example do
          pending
          expect(parser.parse("2 * 3 + 4 * 5").evaluate).to be == 26
        end
      end

      context "brackets" do
        # rule primary
        #   number
        #   /
        #   '(' space expression space ')' {
        #     def evaluate
        #       expression.evaluate
        #     end
        #   }
        # end

        example do
          pending
          expect(parser.parse("(2 + 3) * (4 + 5)").evaluate).to be == 45
        end
      end

      # Go for extra credit
    end
  end
end