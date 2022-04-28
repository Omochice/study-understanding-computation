ZERO = ->p { ->x { x } }
ONE = ->p { ->x { p[x] } }
TWO = ->p { ->x { p[p[x]] } }
THREE = ->p { ->x { p[p[p[x]]] } }
FIVE = ->p { ->x { p[p[p[p[p[x]]]]] } }
FIFTEEN = ->p { ->x { p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[x]]]]]]]]]]]]]]] } }
HANDRED = ->p { ->x { p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[x]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]] } }

TRUE = ->x { ->y { x } }
FALSE = ->x { ->y { y } }

IF =
  ->b {
    ->x {
      ->y {
        b[x][y]
      }
    }
  }

def to_integer(proc)
  return proc[->n { n + 1 }][0]
end

def to_boolean(proc)
  return proc[true][false]
end

def if(proc, x, y)
  return proc[x][y]
end

if $0 == __FILE__
  puts to_integer()
end
