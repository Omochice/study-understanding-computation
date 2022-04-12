class Number < Struct.new(:value)
  def to_s
    return value.to_s
  end

  def inspect
    return "<<#{self}>>"
  end

  def reducible?
    return false
  end
end

class Add < Struct.new(:left, :right)
  def to_s
    return "#{left} + #{right}"
  end

  def inspect
    return "<<#{self}>>"
  end

  def reducible?
    return true
  end

  def reduce
    if left.reducible?
      return Add.new(left.reduce, right)
    elsif right.reducible?
      return Add.new(left, right.reduce)
    else
      return Number.new(left.value + right.value)
    end
  end
end

class Multiply < Struct.new(:left, :right)
  def to_s
    return "#{left} * #{right}"
  end

  def inspect
    return "<<#{self}>>"
  end

  def reducible?
    return true
  end

  def reduce
    if left.reducible?
      return Multiply.new(left.reduce, right)
    elsif right.reducible?
      return Multiply.new(left, right.reduce)
    else
      return Number.new(left.value * right.value)
    end
  end
end

class Boolean < Struct.new(:value)
  def to_s
    return value.to_s
  end

  def inspect
    return "<<#{self}>>"
  end

  def reducible?
    return false
  end
end

class LessThan < Struct.new(:left, :right)
  def to_s
    return "#{left} < #{right}"
  end

  def inspect
    return "<<#{self}>>"
  end

  def reducible?
    true
  end

  def reduce
    if left.reducible?
      return LessThan.new(left.reduce, right)
    elsif right.reducible?
      return LessThan.new(left, right.reduce)
    else
      Boolean.new(left.value < right.value)
    end
  end
end
