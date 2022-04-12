require_relative "./classes.rb"
require_relative "./machine.rb"


Machine.new(
  LessThan.new(Number.new(5), Add.new(Number.new(2), Number.new(1)))
).run
