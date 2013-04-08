require 'spec_helper'
require 'parsing_for_fun_and_profit/simple_ruby/simple_ruby_parser'

module ParsingForFunAndProfit
  module SimpleRuby
    describe SimpleRubyParser do
      subject(:parser) { SimpleRubyParser.new }

      def conversion_method_for_parse_as
        :to_ast
      end

      describe "NWRUG example" do
        example do
          source = -%{
            def initialize(name)
              @name = name
              @hungry = true
            end

            def listen(masters_voice)
              puts("WOOF, WOOF!", @hungry)
            end

            dog = Dog.new("Fido")
            dog.listen("Fido")
          }

          expect(source).to parse_as(
            [:program, [
                [:methdef, [
                    [:keyword, "def"], [:whitespace, " "], [:methname, "initialize"], [:lparen, "("], [:param, "name"], [:rparen, ")"], [:newline, "\n"],
                    [:whitespace, "  "], [:ivar, "@name"], [:whitespace, " "], [:equals, "="], [:whitespace, " "], [:symbol, "name"], [:newline, "\n"],
                    [:whitespace, "  "], [:ivar, "@hungry"], [:whitespace, " "], [:equals, "="], [:whitespace, " "], [:symbol, "true"], [:newline, "\n"],
                    [:keyword, "end"]
                  ]
                ],
                [:newline, "\n"],
                [:newline, "\n"],
                [:methdef, [
                    [:keyword, "def"], [:whitespace, " "], [:methname, "listen"], [:lparen, "("], [:param, "masters_voice"], [:rparen, ")"], [:newline, "\n"],
                    [:whitespace, "  "], [:symbol, "puts"], [:lparen, "("], [:"string-lit", "\"WOOF, WOOF!\""], [:comma, ","], [:whitespace, " "], [:ivar, "@hungry"], [:rparen, ")"], [:newline, "\n"],
                    [:keyword, "end"]
                  ]
                ],
                [:newline, "\n"],
                [:newline, "\n"],
                [:symbol, "dog"], [:whitespace, " "], [:equals, "="], [:whitespace, " "], [:constref, "Dog"], [:dot, "."], [:symbol, "new"], [:lparen, "("], [:"string-lit", "\"Fido\""], [:rparen, ")"], [:newline, "\n"],
                [:symbol, "dog"], [:dot, "."], [:symbol, "listen"], [:lparen, "("], [:"string-lit", "\"Fido\""], [:rparen, ")"]
              ]
            ]
          )
        end
      end

      describe "parsing an empty program" do
        example do
          expect("").to parse_as([:program, []])
        end
      end

      context "whitespace" do
        example do
          expect("   ").to parse_as([:program, [[:whitespace, "   "]]])
        end
      end

      context "comments" do
        example do
          expect("# foo").to parse_as([:program, [[:comment, "# foo"]]])
        end

        example do
          expect("# foo\n# bar").to parse_as(
            [:program, [
                [:comment, "# foo"],
                [:newline, "\n"],
                [:comment, "# bar"]
              ]
            ]
          )
        end

        example do
          expect(" # foo").to parse_as(
            [:program, [
                [:whitespace, " "],
                [:comment, "# foo"]
              ]
            ]
          )
        end

        example do
          expect("bar # foo").to parse_as(
            [:program, [
                [:symbol, "bar"],
                [:whitespace, " "],
                [:comment, "# foo"]
              ]
            ]
          )
        end
      end

      context "simple expressions" do
        example "lvar or message to self" do
          expect("foo").to parse_as([:program, [[:symbol, "foo"]]])
        end

        example "structure of sequence of symbols" do
          expect("foo\nbar\nbaz").to parse_as(
            [:program, [
                [:symbol, "foo"], [:newline, "\n"],
                [:symbol, "bar"], [:newline, "\n"],
                [:symbol, "baz"]
              ]
            ]
          )
        end
      end

      context "strings" do
        example do
          expect('""').to parse_as([:program, [[:"string-lit", '""']]])
        end
        example do
          expect('"foo"').to parse_as([:program, [[:"string-lit", '"foo"']]])
        end
      end

      context "constants" do
        example do
          expect('Foo').to parse_as([:program, [[:constref, 'Foo']]])
        end
      end

      context "instance variables" do
        example do
          expect('@foo').to parse_as([:program, [[:ivar, '@foo']]])
        end
      end

      context "assignment" do
        example do
          expect("foo = bar").to parse_as(
            [:program, [
                [:symbol, "foo"], [:whitespace, " "],
                [:equals, "="], [:whitespace, " "],
                [:symbol, "bar"]
              ]
            ]
          )
        end

        example do
          expect("foo=bar").to parse_as(
            [:program, [
                [:symbol, "foo"],
                [:equals, "="],
                [:symbol, "bar"]
              ]
            ]
          )
        end

        context "to an instance variable" do
          example do
            expect("@foo=bar").to parse_as(
              [:program, [
                  [:ivar, "@foo"],
                  [:equals, "="],
                  [:symbol, "bar"]
                ]
              ]
            )
          end
        end

        context "with a method" do
          example do
            expect("foo=bar.baz()").to parse_as(
              [:program, [
                  [:symbol, "foo"],
                  [:equals, "="],
                  [:symbol, "bar"],
                  [:dot, "."],
                  [:symbol, "baz"],
                  [:lparen, "("],
                  [:rparen, ")"]
                ]
              ]
            )
          end
        end
      end

      context "method calls" do
        example do
          expect("foo.bar").to parse_as(
            [:program, [
                [:symbol, "foo"], [:dot, "."], [:symbol, "bar"]
              ]
            ]
          )
        end

        example do
          expect("Foo.bar").to parse_as(
            [:program, [
                [:constref, "Foo"], [:dot, "."], [:symbol, "bar"]
              ]
            ]
          )
        end

        example do
          expect("foo.bar()").to parse_as(
            [:program, [
                [:symbol, "foo"], [:dot, "."], [:symbol, "bar"],
                [:lparen, "("], [:rparen, ")"]
              ]
            ]
          )
        end

        example do
          expect("foo.bar(baz)").to parse_as(
            [:program, [
                [:symbol, "foo"], [:dot, "."], [:symbol, "bar"],
                [:lparen, "("], [:symbol, "baz"], [:rparen, ")"]
              ]
            ]
          )
        end

        example do
          expect('foo.bar("baz")').to parse_as(
            [:program, [
                [:symbol, "foo"], [:dot, "."], [:symbol, "bar"],
                [:lparen, "("], [:"string-lit", '"baz"'], [:rparen, ")"]
              ]
            ]
          )
        end

        example do
          expect("bar(baz)").to parse_as(
            [:program, [
                [:symbol, "bar"], [:lparen, "("], [:symbol, "baz"], [:rparen, ")"]
              ]
            ]
          )
        end

        example do
          expect('bar("baz")').to parse_as(
            [:program, [
                [:symbol, "bar"], [:lparen, "("], [:"string-lit", '"baz"'], [:rparen, ")"]
              ]
            ]
          )
        end

        example do
          expect('bar("baz", quux ,@foo)').to parse_as(
            [:program, [
                [:symbol, "bar"], [:lparen, "("],
                  [:"string-lit", '"baz"'],
                  [:comma, ","],
                  [:whitespace, " "],
                  [:symbol, "quux"],
                  [:whitespace, " "],
                  [:comma, ","],
                  [:ivar, "@foo"],
                [:rparen, ")"],
              ]
            ]
          )
        end
      end

      context "method definition" do
        example do
          source = -%{
            def foo
              bar
              baz
            end
          }

          expect(source).to parse_as(
            [:program, [
                [:methdef, [
                    [:keyword, "def"], [:whitespace, " "], [:methname, "foo"], [:newline, "\n"],
                    [:whitespace, "  "], [:symbol, "bar"], [:newline, "\n"],
                    [:whitespace, "  "], [:symbol, "baz"], [:newline, "\n"],
                    [:keyword, "end"]
                  ]
                ]
              ]
            ]
          )
        end

        example do
          source = -%{
            def foo()
            end
          }

          expect(source).to parse_as(
            [:program, [
                [:methdef, [
                    [:keyword, "def"],
                      [:whitespace, " "],
                      [:methname, "foo"],
                      [:lparen, "("],
                      [:rparen, ")"],
                      [:newline, "\n"],
                    [:keyword, "end"]
                  ]
                ]
              ]
            ]
          )
        end

        example do
          source = -%{
            def foo(bar)
            end
          }

          expect(source).to parse_as(
            [:program, [
                [:methdef, [
                    [:keyword, "def"],
                      [:whitespace, " "],
                      [:methname, "foo"],
                      [:lparen, "("],
                      [:param, "bar"],
                      [:rparen, ")"],
                      [:newline, "\n"],
                    [:keyword, "end"]
                  ]
                ]
              ]
            ]
          )
        end

        example do
          source = -%{
            def foo(bar , baz,quux)
            end
          }

          expect(source).to parse_as(
            [:program, [
                [:methdef, [
                    [:keyword, "def"],
                      [:whitespace, " "],
                      [:methname, "foo"],
                      [:lparen, "("],
                      [:param, "bar"],
                      [:whitespace, " "],
                      [:comma, ","],
                      [:whitespace, " "],
                      [:param, "baz"],
                      [:comma, ","],
                      [:param, "quux"],
                      [:rparen, ")"],
                      [:newline, "\n"],
                    [:keyword, "end"]
                  ]
                ]
              ]
            ]
          )
        end

        example "with comment" do
          source = -%{
            def foo # I am foo
              # I explain foo
            end
          }

          expect(source).to parse_as(
            [:program, [
                [:methdef, [
                    [:keyword, "def"],
                      [:whitespace, " "],
                      [:methname, "foo"],
                      [:whitespace, " "],
                      [:comment, "# I am foo"],
                      [:newline, "\n"],
                      [:whitespace, "  "],
                      [:comment, "# I explain foo"],
                      [:newline, "\n"],
                    [:keyword, "end"]
                  ]
                ]
              ]
            ]
          )
        end
      end
    end
  end
end
