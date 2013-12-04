maybe_a_list =
  list
  /
  not_a_list

list =
  list_with_elements
  /
  empty_list

empty_list =
  "[" blank "]" { return [ ] }

list_with_elements =
  "[" blank elements:list_elements blank "]" {
    return elements
  }

list_elements =
  first:list_element rest:(blank "," blank another:list_element)* {
    return [first].concat(
      _.map(rest, function(next) {
        return next[3]
      })
    )
  }

list_element =
  symbol
  /
  list

symbol =
  text:[a-z]+ { return text.join("") }

not_a_list =
  "" { return 'nothing' }

blank =
  " "*