class Number < Struct.new(:value)
  def to_s
    return value.to_s
  end

  def inspect
    return "<<#{self}>>"
  end
end

class Add < Struct.new(:left, :right)
  def to_s
    return "#{left} + #{right}"
  end

  def inspect
    return "<<#{self}>>"
  end
end

class Multiply < Struct.new(:left, :right)
  def to_s
    return "#{left} * #{right}"
  end

  def inspect
    return "<<#{self}>>"
  end
end
