class DoNothing
  def to_s
    return "do-nothing"
  end

  def inspect
    return "<<#{self}"
  end

  def ==(other_statement)
    return other_statement.instance_of?(DoNothing)
  end

  def reducible?
    return false
  end
end

class Assign < Struct.new(:name, :expression)
  def to_s
    return "#{name} = #{expression}"
  end

  def inspect
    return "<<#{self}>>"
  end

  def reducible?
    return true
  end

  def reduce(environment = {})
    if expression.reducible?
      return [Assign.new(name, expression.reduce(environment)), environment]
    else
      return [DoNothing.new, environment.merge({ name => expression })]
    end
  end
end

class If < Struct.new(:condition, :consequence, :alternative)
  def to_s
    return "if (#{condition}) { #{consequence} } else { #{alternative} }"
  end

  def inspect
    return "<<#{self}>>"
  end

  def reducible?
    return true
  end

  def reduce(environment = {})
    if condition.reducible?
      return [If.new(condition.reduce(environment), consequence, alternative), environment]
    else
      case condition
      when Boolean.new(true)
        return [consequence, environment]
      when Boolean.new(false)
        return [alternative, environment]
      end
    end
  end
end

class Sequence < Struct.new(:first, :second)
  def to_s
    return "#{first} #{second}"
  end

  def inspect
    return "<<#{self}>>"
  end

  def reducible?
    return true
  end

  def reduce(environment = {})
    case first
    when DoNothing.new
      return [second, environment]
    else
      reduced_first, reduced_environment = first.reduce(environment)
      return [Sequence.new(reduced_first, second), reduced_environment]
    end
  end
end

class While < Struct.new(:condition, :body)
  def to_s
    return "while (#{condition}) { #{body} }"
  end

  def inspect
    return "<<#{self}>>"
  end

  def reducible?
    return true
  end

  def reduce(environment = {})
    return [If.new(condition, Sequence.new(body, self), DoNothing.new), environment]
  end
end
