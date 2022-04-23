require_relative "./stack.rb"

p stack = Stack.new("abcde".split(""))
p stack.top
p stack.pop.pop.top
p stack.push("x").push("y").top
p stack.push("x").push("y").pop.top

