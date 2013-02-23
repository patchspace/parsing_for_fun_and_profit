require 'treetop'
Treetop.load(File.dirname(__FILE__) + '/arithmetic')

# This code also nicked from the Treeptop examples,
# I've just added comments

module ParsingForFunAndProfit
  module Arithmetic
    class BinaryOperation < Treetop::Runtime::SyntaxNode
      # Take the value of `head` and iteratively call `apply` on the
      # next operator with the current total and the next value.
      # So "1 + 2 + 3 + 4" is evaluated as (((1 + 2) + 3) + 4).

      # Parsing Expression Grammars *cannot* do left recursion,
      # eg we can't define anything like
      #   addition_expression => (addition_expression OR number) '+' number
      # as it causes an infinite loop between the two `addition_expression`s

      # You see this pattern a lot - it's not too hard when you're used to it,
      # but it's something I had to gloss over a bit in the talk
      def evaluate
        tail.elements.inject(head.evaluate) do |value, element|
          element.operator.apply(value, element.operand.evaluate)
        end
      end
    end
  end
end