class TMConfiguration < Struct.new(:state, :tape)
end

class TMRule < Struct.new(:state, :character, :next_state, :write_character, :direction)
  def applies_to?(configuration)
    return self.state == configuration.state \
             && self.character == configuration.tape.middle
  end

  def follow(configuration)
    return TMConfiguration.new(next_state, next_tape(configuration))
  end

  def next_tape(configuration)
    written_tape = configuration.tape.write(self.write_character)
    case direction
    when :left
      written_tape.move_head_left
    when :right
      written_tape.move_head_right
    end
    return written_tape
  end
end
