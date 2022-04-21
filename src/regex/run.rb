require_relative "./pattern.rb"

pattern = Concatenate.new(Literal.new("a"), Literal.new("b"))
p pattern
p pattern.matches?("a")
p pattern.matches?("ab")
p pattern.matches?("abc")

pattern = Concatenate.new(
  Concatenate.new(Literal.new("a"), Literal.new("b")),
  Literal.new("c")
)
p pattern
p pattern.matches?("a")
p pattern.matches?("ab")
p pattern.matches?("abc")
