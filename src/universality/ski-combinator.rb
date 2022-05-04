class SKISymbol < Struct.new(:name)
  def to_s
    return self.name.to_s
  end

  def inspect
    return to_s
  end

  def combinator
    return self
  end

  def arguments
    return []
  end

  def callable?(*_arguments)
    return false
  end

  def reducible?
    return false
  end
end

class SKICall < Struct.new(:left, :right)
  def to_s
    return "#{self.left}[#{self.right}]"
  end

  def inspect
    return to_s
  end

  def combinator
    return self.left.combinator
  end

  def arguments
    return self.left.arguments + [self.right]
  end

  def reducible?
    return self.left.reducible? || self.right.reducible? || combinator().callable?(*arguments())
  end

  def reduce
    if left.reducible?
      return SKICall.new(self.left.reduce(), self.right)
    elsif right.reducible?
      return SKICall.new(self.left, self.right.reduce())
    else
      return combinator.call(*arguments())
    end
  end
end

class SKICombinator < SKISymbol
  def callable?(*arguments)
    return arguments.length == method(:call).arity
  end
end

S, K, I = [:S, :K, :I].map { |name| SKICombinator.new(name) }

def S.call(a, b, c)
  return SKICall.new(SKICall.new(a, c), SKICall.new(b, c))
end

def K.call(a, _b)
  return a
end

def I.call(a)
  return a
end
