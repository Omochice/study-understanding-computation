require_relative "./pattern.rb"

pattern =
  Repeat.new(
    Choose.new(
      Concatenate.new(Literal.new("a"), Literal.new("b")),
      Literal.new("a")
    )
  )

p pattern
