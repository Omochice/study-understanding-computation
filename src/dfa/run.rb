require_relative "./farule.rb"

rulebook = DFARuleBook.new([
  FARule.new(1, "a", 2), FARule.new(1, "b", 1),
  FARule.new(2, "a", 2), FARule.new(2, "b", 3),
  FARule.new(3, "a", 3), FARule.new(3, "b", 3),
])

dfa = DFA.new(1, [3], rulebook)
p dfa.accepting?

dfa.read_character("b")
p dfa.accepting?

3.times do
  dfa.read_character("a")
end
p dfa.accepting?

dfa.read_character("b")
p dfa.accepting?

dfa = DFA.new(1, [3], rulebook)
dfa.accepting?
dfa.read_string("baaaaab")
dfa.accepting?
