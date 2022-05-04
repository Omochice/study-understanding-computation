class SKISymbol < Struct.new(:name)
  def to_s
    return self.name.to_s
  end

  def inspect
    return to_s
  end
end

class SKICall < Struct.new(:left, :right)
  def to_s
    return "#{self.left}[#{self.right}]"
  end

  def inspect
    return to_s
  end
end

class SKICombinator < SKISymbol
end

S, K, I = [:S, :K, :I].map { |name| SKISymbol.new(name) }

def S.call(a, b, c)
  return SKICall.new(SKICall.new(a, c), SKICall.new(b, c))
end

def K.call(a, _b)
  return a
end

def I.call(a)
  return a
end
