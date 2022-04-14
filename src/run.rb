require_relative "./classes.rb"
require_relative "./machine.rb"
require_relative "./statements.rb"

env = { x: 3 }
proc = eval(Add.new(Variable.new(:x), Number.new(1)).to_ruby)
p proc.call(env)
