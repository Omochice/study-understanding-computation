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
