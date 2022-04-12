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
