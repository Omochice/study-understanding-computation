ZERO = ->p { ->x { x } }
ONE = ->p { ->x { p[x] } }
TWO = ->p { ->x { p[p[x]] } }
THREE = ->p { ->x { p[p[p[x]]] } }
FIVE = ->p { ->x { p[p[p[p[p[x]]]]] } }
FIFTEEN = ->p { ->x { p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[x]]]]]]]]]]]]]]] } }
HANDRED = ->p { ->x { p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[x]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]] } }

TRUE = ->x { ->y { x } }
FALSE = ->x { ->y { y } }

IF = ->b { b }
IS_ZERO = ->n { n[->x { FALSE }][TRUE] }
IS_LESS_OR_EQUAL = ->m {
  ->n {
    IS_ZERO[SUBSTRACT[m][n]]
  }
}

PAIR = ->x { ->y { ->f { f[x][y] } } }
LEFT = ->p { p[->x { ->y { x } }] }
RIGHT = ->p { p[->x { ->y { y } }] }

INCREMENT = ->n { ->p { ->x { p[n[p][x]] } } }
SLIDE = ->p { PAIR[RIGHT[p]][INCREMENT[RIGHT[p]]] }
DECREMENT = ->n { LEFT[n[SLIDE][PAIR[ZERO][ZERO]]] }

ADD = ->m { ->n { n[INCREMENT][m] } }
SUBSTRACT = ->m { ->n { n[DECREMENT][m] } }
MULTIPLY = ->m { ->n { n[ADD[m]][ZERO] } }
MOD = ->m {
  ->n {
    IF[IS_LESS_OR_EQUAL[n][m]][
      ->x {
        # lazy ecaluation by dummy proc
        MOD[SUBSTRACT[m][n]][n][x]
      }
    ][
      m
    ]
  }
}
POWER = ->m { ->n { n[MULTIPLY[m]][ONE] } }

Y = ->f {
  ->x {
    f[x[x]]
  }[->x { f[x[x]] }]
}

Z = ->f {
  ->x { f[->y { x[x][y] }] }[
    ->x { f[->y { x[x][y] }] }
  ]
}

def to_integer(proc)
  return proc[->n { n + 1 }][0]
end

def to_boolean(proc)
  return IF[proc][true][false]
end

def if(proc, x, y)
  return proc[x][y]
end

if $0 == __FILE__
  puts to_integer()
end
