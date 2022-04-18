require_relative "./farule.rb"

rulebook = DFARuleBook.new([
  FARule.new(1, "a", 2), FARule.new(1, "b", 1),
  FARule.new(2, "a", 2), FARule.new(2, "b", 3),
  FARule.new(3, "a", 3), FARule.new(3, "b", 3),
])

dfa_design = DFADesign.new(1, [3], rulebook)
p dfa_design.accepts?("a")
p dfa_design.accepts?("baa")
p dfa_design.accepts?("baba")

