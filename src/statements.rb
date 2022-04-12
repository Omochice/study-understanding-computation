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
      return [DoNothing.new, environment.merge({ name: expression })]
    end
  end
end
