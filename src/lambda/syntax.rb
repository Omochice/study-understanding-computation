class LCVariable < Struct.new(:name)
  def to_s
    return self.name.to_s
  end

  def inspect
    return to_s
  end

  def replace(name, replacement)
    if self.name == name
      return replacement
    else
      return self
    end
  end
end

class LCFunction < Struct.new(:parameter, :body)
  def to_s
    return "-> #{self.parameter} { #{self.body} }"
  end

  def inspect
    return to_s
  end

  def replace(name, replacement)
    if self.parameter == name
      return self
    else
      return LCFunction.new(self.parameter, self.body.replace(name, replacement))
    end
  end

  def call(argument)
    return body.replace(self.parameter, argument)
  end
end
    #

class LCCall < Struct.new(:left, :right)
  def to_s
    return "#{self.left}[#{self.right}]"
  end

  def inspect
    return to_s
  end

  def replace(name, replacement)
    return LCCall.new(self.left.replace(name, replacement),
                      self.right.replace(name, replacement))
  end
end
