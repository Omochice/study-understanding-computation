class Stack < Struct.new(:contents)
  # Each calling function, create new instance.
  # This is not good efficiency.
  # But make easy to handle.
  def push(character)
    return Stack.new([character] + contents)
  end

  def pop
    return Stack.new(contents.drop(1))
  end

  def top
    return contents.first
  end

  def inspect
    return "#<Stack {#{top}}#{contents.drop(1).join}>"
  end
end
