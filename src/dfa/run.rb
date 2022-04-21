require_relative "./nfa.rb"
require "set"

# rulebook = DFARuleBook.new([
#   FARule.new(1, "a", 2), FARule.new(1, "b", 1),
#   FARule.new(2, "a", 2), FARule.new(2, "b", 3),
#   FARule.new(3, "a", 3), FARule.new(3, "b", 3),
# ])
#
# dfa_design = DFADesign.new(1, [3], rulebook)
# p dfa_design.accepts?("a")
# p dfa_design.accepts?("baa")
# p dfa_design.accepts?("baba")

rulebook = NFARulebook.new([
  FARule.new(1, nil, 2), FARule.new(1, nil, 4),
  FARule.new(2, "a", 3),
  FARule.new(3, "a", 2),
  FARule.new(4, "a", 5),
  FARule.new(5, "a", 6),
  FARule.new(6, "a", 4),
])

nfa_design = NFADesign.new(1, [2, 4], rulebook)
p nfa_design.accepts?("aa")
p nfa_design.accepts?("aaa")
p nfa_design.accepts?("aaaa")
p nfa_design.accepts?("aaaaa")
