require_relative "./classes.rb"
require_relative "./machine.rb"

Machine.new(
  Add.new(Variable.new(:x), Variable.new(:y)),
  { x: Number.new(3), y: Number.new(4) }
).run
