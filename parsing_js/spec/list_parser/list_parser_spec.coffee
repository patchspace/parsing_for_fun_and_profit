require '../spec_helper.coffee'

# Note: comments are not currently copypastable
# into a runnable grammar
describe "List", ->
  parser = null

  beforeEach ->
    parser = newListParser()

  parse = (text) -> parser.parse(text)

  # not_a_list =
  #   "" { return 'nothing' }
  specify "nothing", ->
    expect(parse('')).to.equal 'nothing'

  # maybe_a_list =
  #   list
  #   /
  #   not_a_list
  #
  # list =
  #   "[]" { return [ ] }
  xspecify "empty list", ->
    expect(parse('[]')).to.deep.equal [ ]

  # list =
  #   "[" blank "]" { return [ ] }
  #
  # blank =
  #   " "*
  xspecify "empty list with spaces", ->
    expect(parse('[   ]')).to.deep.equal [ ]

  # list =
  #   empty_list
  #   /
  #   list_with_elements
  #
  # empty_list =
  #   "[" blank "]" { return [ ] }
  #
  # list_with_elements =
  #   "[" item:list_item "]" { return [item] }
  #
  # list_item =
  #   "a" { return "a" }
  xspecify "one item", ->
    expect(parse('[a]')).to.deep.equal ['a']

  # list_item =
  #   label:[a-z] { return label }
  xspecify "a different item", ->
    expect(parse('[z]')).to.deep.equal ['z']

  # PEG.js-specific point
  xspecify "longer items", ->
    # console.log() is your friend
    expect(parse('[abc]')).to.deep.equal ['abc']

  # list_with_elements =
  #   "[" blank item:list_item blank "]" { return [item] }
  xspecify "one item with whitespace", ->
    expect(parse('[ a ]')).to.deep.equal ['a']

  # Not this: list_elements "," list_element / list_element
  #
  # list_with_elements =
  #   "[" blank items:list_items blank "]" { return items }
  #
  # list_items =
  #   first:list_item rest:("," next:list_item)* {
  #     return [first].concat(
  #       _.map(rest, function(another) {
  #           return another[1][0]
  #       })
  #     )
  #   }
  xspecify "multiple items", ->
    expect(parse('[a,b,c]')).to.deep.equal ['a', 'b', 'c']

  # list_items =
  #   first:list_item rest:(blank "," blank next:list_item)* {
  #     return [first].concat(
  #       _.map(rest, function(another) {
  #           return another[3][0]
  #       })
  #     )
  #   }
  xspecify "multiple items with whitespace", ->
    expect(parse('[ a , b , c ]')).to.deep.equal ['a', 'b', 'c']

  # list_item =
  #   symbol
  #   /
  #   list
  #
  # symbol =
  #   label:[a-z] { return label }
  xspecify "a list containing an empty list", ->
    expect(parse('[ [] ]')).to.deep.equal [ [] ]

  # TODO: Maybe pre-empt this? Or not...
  #
  # list_items =
  #   first:list_item rest:(blank "," blank next:list_item)* {
  #     return [first].concat(
  #       _.map(rest, function(another) {
  #           return another[3]
  #       })
  #     )
  #   }
  #
  # list_item =
  #   symbol:symbol { return symbol }
  #   /
  #   list:list { return list }
  xspecify "a symbol and a list", ->
    expect(parse('[ a, [] ]')).to.deep.equal [ 'a', [] ]

  xspecify "two lists", ->
    expect(parse('[ [], [] ]')).to.deep.equal [ [], [] ]

  xspecify "a complex nested list", ->
    expect(parse('[a, [ b, c, [] ], [d], e]')).to.deep.equal(
      ['a', [ 'b', 'c', [] ], ['d'], 'e']
    )
