require_relative "./classes.rb"
require_relative "./machine.rb"
require_relative "./statements.rb"

p Number.new(23).evaluate
p Variable.new(:x).evaluate({ x: Number.new(2) })
p LessThan.new(
  Add.new(Variable.new(:x), Number.new(2)),
  Variable.new(:y)
).evaluate({x: Number.new(2), y: Number.new(5)})
