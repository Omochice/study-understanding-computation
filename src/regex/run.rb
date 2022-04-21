require_relative "./pattern.rb"

pattern = Repeat.new(Literal.new("a"))
p pattern
p pattern.matches?("")
p pattern.matches?("a")
p pattern.matches?("aaaa")
p pattern.matches?("b")
