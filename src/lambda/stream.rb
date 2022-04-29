require_relative "./array.rb"
require_relative "./combinator.rb"
require_relative "./operators.rb"
require_relative "./numbers.rb"

ZEROS = Z[->f { UNSHIFT[f][ZERO] }]
UPWARD_OF = Z[->f { ->n { UNSHIFT[->x { f[INCREMENT[n]][x] }][n] } }]
MULTIPLY_OF = ->m {
  Z[->f {
      ->n { UNSHIFT[->x { f[ADD[m][n]][x] }][n] }
    }][m]
}
