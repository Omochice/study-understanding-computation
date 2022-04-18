require_relative "./farule.rb"

rulebook = DFARuleBook.new([
  FARule.new(1, "a", 2), FARule.new(1, "b", 1),
  FARule.new(2, "a", 2), FARule.new(2, "b", 3),
  FARule.new(3, "a", 3), FARule.new(3, "b", 3),
])

p rulebook
p rulebook.next_state(1, "a")
p rulebook.next_state(1, "b")
p rulebook.next_state(2, "b")
