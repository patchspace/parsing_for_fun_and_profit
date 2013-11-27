require 'ap'
require 'lstrip-on-steroids'

RSpec.configure do |config|
  config.filter_run(focus: true)
  config.run_all_when_everything_filtered = true
end

RSpec::Matchers.define :parse do
  match do |source|
    parser.parse(source)
  end
end

# This was priceless when writing the SimpleRuby parser, but it
# relies on the `to_ast` method which is fairly complex
RSpec::Matchers.define :parse_as do |expected_tree|
  match do |source|
    @expected = expected_tree

    @actual_parsed = parser.parse(source)

    if @actual_parsed
      @actual = @actual_parsed.send(conversion_method_for_parse_as) if @actual_parsed
    else
      @failure = { line: parser.failure_line, column: parser.failure_column, reason: parser.failure_reason }
    end

    @actual == @expected
  end

  failure_message_for_should do
    if @actual_parsed
      "Expected tree:\n#{@expected.ai}\n" +
      "Got this:\n#{@actual.ai}\n" +
      "Parsed source:\n#{@actual_parsed.ai}"
    else
      "Failure (at #{@failure[:line]}:#{@failure[:column]}):\n" +
      "#{@failure[:reason]}"
    end
  end
end