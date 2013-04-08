require 'treetop'
Treetop.load(File.dirname(__FILE__) + '/list')

module ParsingForFunAndProfit
  module List
    module List
      # A common trick I use is to re-open Treetop's SyntaxNode base class
      # to add default generic behaviour to any node we get back, which given
      # the bizarre trees you can get back from Treetop is very useful
      #
      # These are commented out for demo-ing purposes
      class ::Treetop::Runtime::SyntaxNode
        # def to_list
        #   nil
        # end

        # def to_list
        #   [ ]
        # end
      end
    end
  end
end