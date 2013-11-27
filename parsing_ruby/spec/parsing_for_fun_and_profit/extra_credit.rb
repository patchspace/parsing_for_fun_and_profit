describe "shove this up your regex" do
  example do
    expect(parser.parse("(2 + 3) * (4 + 5) * ((5 + 1) + (1 + 2))").evaluate).to be == 405
  end
end

describe "subtraction" do
  example do
    expect(parser.parse("(1 + 2) * (5 - 3)").evaluate).to be == 6
  end
end