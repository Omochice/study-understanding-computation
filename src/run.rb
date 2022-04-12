require_relative "./classes.rb"
require_relative "./machine.rb"
require_relative "./statements.rb"

Machine.new(
  Assign.new(:x,
             Add.new(Variable.new(:x), Number.new(1))),
  { x: Number.new(2) }
).run

# Machine.new(
#   Multiply.new(Variable.new(:x), Variable.new(:y)),
#   { x: Number.new(3), y: Number.new(4) }
# ).run
# Machine.new(
#   Add.new(Variable.new(:x), Variable.new(:y)),
#   { x: Number.new(3), y: Number.new(4) }
# ).run
