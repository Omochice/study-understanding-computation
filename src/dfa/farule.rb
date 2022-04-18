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

