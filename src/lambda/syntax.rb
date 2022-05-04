require_relative "../universality/ski-combinator.rb"

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

  def callable?
    return false
  end

  def reducible?
    return false
  end

  def to_ski
    return SKISymbol.new(self.name)
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

  def callable?
    return true
  end

  def reducible?
    return false
  end

  def to_ski
    return self.body.to_ski.as_a_function_of(self.parameter)
  end
end

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

  def callable?
    return false
  end

  def reducible?
    return self.left.reducible? || self.right.reducible? || self.left.callable?
  end

  def reduce
    if self.left.reducible?
      return LCCall.new(self.left.reduce, self.right)
    elsif self.right.reducible?
      return LCCall.new(self.left, self.right.reduce)
    else
      return self.left.call(self.right)
    end
  end

  def to_ski
    return SKICall.new(self.left.to_ski, self.right.to_ski)
  end
end
