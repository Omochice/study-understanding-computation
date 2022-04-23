require_relative "./nfa.rb"
require "set"

rulebook = NFARulebook.new([
  FARule.new(1, "a", 1), FARule.new(1, "a", 2), FARule.new(1, nil, 2),
  FARule.new(2, "b", 3),
  FARule.new(3, "b", 1), FARule.new(3, nil, 1),
])

nfa_design = NFADesign.new(1, [3], rulebook)
# p nfa_design.to_nfa.current_states
# p nfa_design.to_nfa(Set[2]).current_states
# p nfa_design.to_nfa(Set[3]).current_states

nfa = nfa_design.to_nfa(Set[2,3])
nfa.read_character("b")
p nfa.current_states
