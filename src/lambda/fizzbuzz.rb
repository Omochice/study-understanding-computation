ZERO = ->p { ->x { x } }
ONE = ->p { ->x { p[x] } }
TWO = ->p { ->x { p[p[x]] } }
THREE = ->p { ->x { p[p[p[x]]] } }

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
