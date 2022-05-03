require_relative "./array.rb"
require_relative "./combinator.rb"
require_relative "./operators.rb"
require_relative "./numbers.rb"

ZEROS = Z[->f { UNSHIFT[f][ZERO] }]
UPWARDS_OF = Z[->f { ->n { UNSHIFT[->x { f[INCREMENT[n]][x] }][n] } }]
MULTIPLES_OF = ->m {
  Z[->f {
      ->n { UNSHIFT[->x { f[ADD[m][n]][x] }][n] }
    }][m]
}
MULTIPLY_STREAMS = Z[->f {
                       ->k {
                         ->l {
                           UNSHIFT[->x { f[REST[k]][REST[l]][x] }][MULTIPLY[FIRST[k]][FIRST[l]]]
                         }
                       }
                     }]
