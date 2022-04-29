require_relative "./array.rb"
require_relative "./combinator.rb"
require_relative "./numbers.rb"
require_relative "./statements.rb"

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
MOD = ->m {
  ->n {
    m[->x {
        IF[IS_LESS_OR_EQUAL[n][x]][
          SUBSTRACT[x][n]
        ][
          x
        ]
      }][m]
  }
}
# MOD = Z[->f {
#           ->m {
#             ->n {
#               IF[IS_LESS_OR_EQUAL[n][m][
#                    ->x {
#                      f[SUBSTRACT[m][n]][n][x]
#                    }
#                  ][
#                    m
#                  ]
#               ]
#             }
#           }
#         }]
POWER = ->m { ->n { n[MULTIPLY[m]][ONE] } }
