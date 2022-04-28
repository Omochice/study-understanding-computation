def one(proc, x)
  return proc[x]
end

def two(proc, x)
  return proc[proc[x]]
end

def three(proc, x)
  return proc[proc[proc[x]]]
end

def zero(proc, x)
  return x
end

if $0 == __FILE__
  (1..100).map do |n|
    if (n % 15).zero?
      return "FizzBuzz"
    elsif (n % 3).zero?
      return "Fizz"
    elsif (n % 5).zero?
      return "Buzz"
    else
      return n.to_s
    end
  end
end
