require_relative "./classes.rb"
require_relative "./machine.rb"
require_relative "./statements.rb"

Machine.new(
  While.new(
    LessThan.new(Variable.new(:x), Number.new(5)),
    Assign.new(:x, Multiply.new(Variable.new(:x), Number.new(3)))
  ),
  { x: Number.new(1) },
).run
