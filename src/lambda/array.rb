require_relative "./boolean.rb"
require_relative "./combinator.rb"
require_relative "./statements.rb"

PAIR = ->x { ->y { ->f { f[x][y] } } }
LEFT = ->p { p[->x { ->y { x } }] }
RIGHT = ->p { p[->x { ->y { y } }] }

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
COUNTDOWN = ->p { PAIR[UNSHIFT[LEFT[p]][RIGHT[p]]][DECREMENT[RIGHT[p]]] }
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
