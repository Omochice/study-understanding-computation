require_relative "./stack.rb"
require_relative "./pushdown-automaton-rule.rb"
require_relative "./deterministic-pushdown-automaton.rb"

rulebook = DPDARulebook.new([
  PDARule.new(1, "(", 2, "$", ["b", "$"]),
  PDARule.new(2, "(", 2, "b", ["b", "b"]),
  PDARule.new(2, ")", 2, "b", []),
  PDARule.new(2, nil, 1, "$", ["$"]),
])

p dpda_design = DPDADesign.new(1, "$", [1], rulebook)
p dpda_design.accepts?("(((((())))))")
p dpda_design.accepts?("((()()()))")
p dpda_design.accepts?("(((((()))))")

