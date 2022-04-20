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
