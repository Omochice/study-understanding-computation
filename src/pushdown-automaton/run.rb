require_relative "./stack.rb"
require_relative "./pushdown-automaton-rule.rb"
require_relative "./deterministic-pushdown-automaton.rb"

rule = PDARule.new(1, "(", 2, "$", ["b", "$"])
# p rule
configuration = PDAConfiguration.new(1, Stack.new(["$"]))
# p configuration
# p rule.applies_to?(configuration, "(")
#
rule.follow(configuration)

rulebook = DPDARulebook.new([
  PDARule.new(1, "(", 2, "$", ["b", "$"]),
  PDARule.new(2, "(", 2, "b", ["b", "b"]),
  PDARule.new(2, ")", 2, "b", []),
  PDARule.new(2, nil, 1, "$", ["$"]),
])

p configuration = rulebook.next_configuration(configuration, "(")
p configuration = rulebook.next_configuration(configuration, "(")
p configuration = rulebook.next_configuration(configuration, ")")
