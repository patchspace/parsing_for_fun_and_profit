# Parsing for Fun and Profit

(Mainly fun)

This is the code for the talk I did at [North West Ruby User Group in February 2013][nwrug] and then again (but new and improved!) and [Sheffield Ruby User Group in April 2013][shrug].

## Code highlights

Here are some highlights in the code you might want to take a look at. One from the simple **arithmetic evaluator demo** I did:

* `arithmetic_parser_spec.rb` is the example we worked through semi-live

And a lot more about the **(Simple)Ruby -> HTML syntax highlighter**:

* `simple_ruby.treetop` is a Treetop grammar for a very small subset of Ruby
* `simple_ruby_parser_spec.rb` shows how I built up the grammar by inspecting a simplified version of the parse tree that Treetop generates
* `spec_helper.rb` shows how to get helpful error messages from Treetop
* `simple_ruby_parser.rb` shows how to transform the sometimes weird and wacky syntax trees you get from Treetop into something more sane

Take a look at `bin/rb2html` for as a jump-off point to see how the syntax highlighter actually runs. You can edit `demo/dog.rb` or just make your own file.

## Contact

If you have any questions or comments, feel free to contact me at [ash.moran@patchspace.co.uk](mailto:ash.moran@patchspace.co.uk).

[nwrug]: http://nwrug.org/events/february-2013-parsing-for-fun-profit/
[shrug]: http://shrug.org/meetings/shrug-41/