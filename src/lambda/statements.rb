require_relative "./boolean.rb"

IF = ->b { b }
IS_ZERO = ->n { n[->x { FALSE }][TRUE] }
IS_LESS_OR_EQUAL = ->m {
  ->n {
    IS_ZERO[SUBSTRACT[m][n]]
  }
}
