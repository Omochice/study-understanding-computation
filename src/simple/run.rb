require_relative "./classes.rb"
require_relative "./machine.rb"
require_relative "./statements.rb"

statement = While.new(
  LessThan.new(Variable.new(:x), Number.new(5)),
  Assign.new(:x, Multiply.new(Variable.new(:x), Number.new(3)))
)

proc = eval(statement.to_ruby)

p proc.call({ x: 1 })
