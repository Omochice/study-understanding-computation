require_relative "./stack.rb"
require_relative "./pushdown-automaton-rule.rb"
require_relative "./deterministic-pushdown-automaton.rb"

rulebook = DPDARulebook.new([
  PDARule.new(1, "(", 2, "$", ["b", "$"]),
  PDARule.new(2, "(", 2, "b", ["b", "b"]),
  PDARule.new(2, ")", 2, "b", []),
  PDARule.new(2, nil, 1, "$", ["$"]),
])

dpda = DPDA.new(PDAConfiguration.new(1, Stack.new(["$"])), [1], rulebook)

p dpda
# p dpda.read_string("(()(")
# p dpda.accepting?
