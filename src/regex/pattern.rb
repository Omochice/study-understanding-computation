module Pattern
  def bracket(outer_precedence)
    if precedence < outer_precedence
      return "(" + to_s + ")"
    else
      return to_s
    end
  end

  def inspect
    return "/#{self}/"
  end
end

class Empty
  include Pattern

  def to_s
    return ""
  end

  def precedence
    return 3
  end
end

class Literal < Struct.new(:character)
  include Pattern

  def to_s
    return character
  end

  def precedence
    return 3
  end
end

class Concatenate < Struct.new(:first, :second)
  include Pattern

  def to_s
    return [first, second].map { |pattern| pattern.bracket(precedence) }.join
  end

  def precedence
    return 1
  end
end

class Choose < Struct.new(:first, :second)
  include Pattern

  def to_s
    return [first, second].map { |pattern| pattern.bracket(precedence) }.join("|")
  end

  def precedence
    return 0
  end
end

class Repeat < Struct.new(:pattern)
  include Pattern

  def to_s
    return pattern.bracket(precedence) + "*"
  end

  def precedence
    return 2
  end
end
