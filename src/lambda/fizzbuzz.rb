Y = ->f { ->x { f[x[x]] }[->x { f[x[x]] }] }
Z = ->f { ->x { f[->y { x[x][y] }] }[->x { f[->y { x[x][y] }] }] }

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
DIV = Z[->f {
          ->m {
            ->n {
              IF[IS_LESS_OR_EQUAL[n][m]][
                ->x {
                  INCREMENT[f[SUBSTRACT[m][n]][n]][x]
                }
              ][
                ZERO
              ]
            }
          }
        }]
MOD = Z[->f {
          ->m {
            ->n {
              IF[IS_LESS_OR_EQUAL[n][m][
                   ->x {
                     f[SUBSTRACT[m][n]][n][x]
                   }
                 ][
                   m
                 ]
              ]
            }
          }
        }]
POWER = ->m { ->n { n[MULTIPLY[m]][ONE] } }

EMPTY = PAIR[TRUE][TRUE]
UNSHIFT = ->l {
  ->x {
    PAIR[FALSE][PAIR[x][l]]
  }
}
IS_EMPTY = LEFT
FIRST = ->l { LEFT[RIGHT[l]] }
REST = ->l { RIGHT[RIGHT[l]] }
RANGE = Z[->f {
            ->m {
              ->n {
                IF[IS_LESS_OR_EQUAL[m][n]][
                  ->x {
                    UNSHIFT[f[INCREMENT[m]][n]][m][x]
                  }
                ][
                  EMPTY
                ]
              }
            }
          }]
# FOLD that like Enumerate#inject
FOLD = Z[
  ->f {
    ->l {
      ->x {
        ->g {
          IF[IS_EMPTY[l]][
            x
          ][
            ->y {
              g[f[REST[l]][x][g]][FIRST[l]][y]
            }
          ]
        }
      }
    }
  }
]
MAP = ->k {
  ->f {
    FOLD[k][EMPTY][
      ->l { ->x { UNSHIFT[l][f[x]] } }
    ]
  }
}
PUSH = ->l { ->x { FOLD[l][UNSHIFT[EMPTY][x]][UNSHIFT] } }

B = MULTIPLY[TWO][FIVE]
F = INCREMENT[B]
I = INCREMENT[F]
U = INCREMENT[I]
ZED = INCREMENT[U]

FIZZ = UNSHIFT[UNSHIFT[UNSHIFT[UNSHIFT[EMPTY][ZED]][ZED]][I]][F]
BUZZ = UNSHIFT[UNSHIFT[UNSHIFT[UNSHIFT[EMPTY][ZED]][ZED]][U]][B]
# FIZZBUZZ = UNSHIFT[UNSHIFT[EMPTY][BUZZ]][FIZZ] # This does not work
FIZZBUZZ = UNSHIFT[UNSHIFT[UNSHIFT[UNSHIFT[BUZZ][ZED]][ZED]][I]][F]

def to_integer(proc)
  return proc[->n { n + 1 }][0]
end

def to_boolean(proc)
  return IF[proc][true][false]
end

def to_array(proc)
  array = []
  until to_boolean(IS_EMPTY[proc])
    array.push(FIRST[proc])
    proc = REST[proc]
  end
  return array
end

def to_char(c)
  return "0123456789BFiuz".slice(to_integer(c))
end

def to_string(s)
  return to_array(s).map { |c| to_char(c) }.join
end

if $0 == __FILE__
  puts to_integer()
end
