class PDAConfiguration < Struct.new(:state, :stack)
  STUCK_STATE = Object.new()

  def stuck
    return PDAConfiguration.new(STUCK_STATE, stack)
  end

  def stuck?
    return state == STUCK_STATE
  end
end

class PDARule < Struct.new(:state, :character, :next_state,
                           :pop_character, :push_characters)
  def applies_to?(configuration, character)
    return self.state == configuration.state \
             && self.pop_character == configuration.stack.top \
             && self.character == character
  end

  def follow(configuration)
    return PDAConfiguration.new(next_state, next_stack(configuration))
  end

  def next_stack(configuration)
    poped_stack = configuration.stack.pop
    return push_characters.reverse.inject(poped_stack) do |stack, character|
             stack.push(character)
           end
  end
end
