require_relative "../../src/lambda/array.rb"
require_relative "../../src/lambda/statements.rb"

def to_integer(proc)
  return proc[->n { n + 1 }][0]
end

def to_boolean(proc)
  return IF[proc][true][false]
end

def to_array(proc, count = nil)
  array = []
  until to_boolean(IS_EMPTY[proc]) || count == 0
    array.push(FIRST[proc])
    proc = REST[proc]
    count = count - 1 unless count.nil?
  end
  return array
end

def to_char(c)
  return "0123456789BFiuz".slice(to_integer(c))
end

def to_string(s)
  return to_array(s).map { |c| to_char(c) }.join
end
