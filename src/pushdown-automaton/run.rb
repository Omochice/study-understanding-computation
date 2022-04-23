require_relative "./stack.rb"
require_relative "./pushdown-automaton-rule.rb"
require_relative "./deterministic-pushdown-automaton.rb"

rulebook = DPDARulebook.new([
  PDARule.new(1, "(", 2, "$", ["b", "$"]),
  PDARule.new(2, "(", 2, "b", ["b", "b"]),
  PDARule.new(2, ")", 2, "b", []),
  PDARule.new(2, nil, 1, "$", ["$"]),
])

p dpda = DPDA.new(PDAConfiguration.new(1, Stack.new(["$"])), [1], rulebook)
p dpda.accepting?

dpda.read_string("(()")
p dpda.accepting?
p dpda.current_configuration
