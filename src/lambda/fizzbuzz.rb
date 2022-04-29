require_relative "./array.rb"
require_relative "./boolean.rb"
require_relative "./combinator.rb"
require_relative "./numbers.rb"
require_relative "./operators.rb"
require_relative "./statements.rb"
require_relative "./strings.rb"

SOLUTION =
  MAP[RANGE[ONE][HANDRED]][->n {
                             IF[IS_ZERO[MOD[n][FIFTEEN]]][
                               FIZZBUZZ
                             ][
                               IF[IS_ZERO[MOD[n][THREE]]][
                                 FIZZ
                               ][
                                 IF[IS_ZERO[MOD[n][FIVE]]][
                                   BUZZ
                                 ][
                                   TO_DIGITS[n]
                                 ]
                               ]
                             ]
                           }]
