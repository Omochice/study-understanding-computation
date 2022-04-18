class FARule < Struct.new(:state, :character, :next_state)
  def applies_to?(state, character)
    return self.state == state && self.character == character
  end

  def follow
    return next_state
  end

  def inspect
    return "$#<FARule #{state.inspect} --#{character}--> #{next_state.inspect}>"
  end
end

class DFARuleBook < Struct.new(:rules)
  def next_state(state, character)
    return rule_for(state, character).follow
  end

  def rule_for(state, character)
    return rules.detect { |rule| rule.applies_to?(state, character) }
  end
end

class DFA < Struct.new(:current_state, :accept_states, :rulebook)
  def accepting?
    return accept_states.include?(current_state)
  end

  def read_character(character)
    self.current_state = rulebook.next_state(current_state, character)
  end

  def read_string(string)
    string.chars.each do |character|
      read_character(character)
    end
  end
end

class DFADesign < Struct.new(:start_state, :accept_states, :rulebook)
  def to_dfa
    return DFA.new(start_state, accept_states, rulebook)
  end

  def accepts?(string)
    return to_dfa.tap { |dfa| dfa.read_string(string) }.accepting?
  end
end
