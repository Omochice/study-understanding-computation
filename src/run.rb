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

expression =
  Add.new(
    Multiply.new(Number.new(1), Number.new(2)),
    Multiply.new(Number.new(3), Number.new(4)),
  )

p expression.reducible?
expression = expression.reduce
expression = expression.reduce
expression = expression.reduce
p expression
