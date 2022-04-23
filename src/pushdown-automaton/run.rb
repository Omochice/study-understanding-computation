require_relative "./stack.rb"
require_relative "./pushdown-automaton-rule.rb"

rule = PDARule.new(1, "(", 2, "$", ["b", "$"])
p rule
configuration = PDAConfiguration.new(1, Stack.new(["$"]))
p configuration
p rule.applies_to?(configuration, "(")

p rule.follow(configuration)
