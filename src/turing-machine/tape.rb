class Tape < Struct.new(:left, :middle, :right, :blank)
  def inspect
    return "<Tape #{left.join} #{middle.join} #{right.join}>"
  end

  def write(character)
    return Tape.new(left, character, right, blank)
  end

  def move_head_left
    return Tape.new(left[0...-1], left.last || blank, [middle] + right, blank)
  end

  def move_head_right
    return Tape.new(left + [middle], right.first || blank, right.drop(1), blank)
  end
end
