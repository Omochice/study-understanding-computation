require_relative "./array.rb"
require_relative "./combinator.rb"
require_relative "./numbers.rb"
require_relative "./operators.rb"
require_relative "./statements.rb"

B = MULTIPLY[TWO][FIVE]
F = INCREMENT[B]
I = INCREMENT[F]
U = INCREMENT[I]
ZED = INCREMENT[U]

FIZZ = UNSHIFT[UNSHIFT[UNSHIFT[UNSHIFT[EMPTY][ZED]][ZED]][I]][F]
BUZZ = UNSHIFT[UNSHIFT[UNSHIFT[UNSHIFT[EMPTY][ZED]][ZED]][U]][B]
# FIZZBUZZ = UNSHIFT[UNSHIFT[EMPTY][BUZZ]][FIZZ] # This does not work
FIZZBUZZ = UNSHIFT[UNSHIFT[UNSHIFT[UNSHIFT[BUZZ][ZED]][ZED]][I]][F]

TO_DIGITS = Z[->f {
                ->n {
                  PUSH[
                    IF[IS_LESS_OR_EQUAL[n][DECREMENT[MULTIPLY[TWO][FIVE]]]][
                      EMPTY
                    ][
                      ->x {
                        f[DIV[n][MULTIPLY[TWO][FIVE]]][x]
                      }
                    ]
                  ][MOD[n][MULTIPLY[TWO][FIVE]]]
                }
              }]
