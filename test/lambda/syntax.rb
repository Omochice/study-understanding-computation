require "minitest/autorun"
require_relative "../../src/lambda/syntax.rb"

class LambdaCalculusTest < Minitest::Test
  def setup
    @one = LCFunction.new(:p,
                          LCFunction.new(:x,
                                         LCCall.new(LCVariable.new(:p), LCVariable.new(:x))))
    @increment = LCFunction.new(
      :n,
      LCFunction.new(
        :p,
        LCFunction.new(
          :x,
          LCCall.new(
            LCVariable.new(:p),
            LCCall.new(
              LCCall.new(LCVariable.new(:n),
                         LCVariable.new(:p)),
              LCVariable.new(:x),
            )
          )
        )
      )
    )
    @add =
      LCFunction.new(:m,
                     LCFunction.new(:n,
                                    LCCall.new(LCCall.new(LCVariable.new(:n), @increment),
                                               LCVariable.new(:m))))
  end

  def test_one
    assert_equal("-> p { -> x { p[x] } }", @one.to_s)
  end

  def test_increment
    assert_equal("-> n { -> p { -> x { p[n[p][x]] } } }", @increment.to_s)
  end

  def test_add
    assert_equal("-> m { -> n { n[-> n { -> p { -> x { p[n[p][x]] } } }][m] } }", @add.to_s)
  end

  def test_expression
    expression = LCVariable.new(:x)
    assert_equal("x", expression.to_s)
    assert_equal("-> y { y }", expression.replace(:x, LCFunction.new(:y, LCVariable.new(:y))).to_s)

    expression =
      LCCall.new(
        LCCall.new(
          LCCall.new(
            LCVariable.new(:a),
            LCVariable.new(:b),
          ),
          LCVariable.new(:c)
        ),
        LCVariable.new(:b)
      )
    assert_equal("a[b][c][b]", expression.to_s)
    assert_equal("x[b][c][b]", expression.replace(:a, LCVariable.new(:x)).to_s)
    assert_equal("a[-> x { x }][c][-> x { x }]",
                 expression.replace(:b, LCFunction.new(:x, LCVariable.new(:x))).to_s)

    expression =
      LCFunction.new(:y,
                     LCCall.new(LCVariable.new(:x), LCVariable.new(:y)))
    assert_equal("-> y { x[y] }", expression.to_s)
    assert_equal("-> y { z[y] }", expression.replace(:x, LCVariable.new(:z)).to_s)
    # `replace` replace only free variables
    assert_equal("-> y { x[y] }", expression.replace(:y, LCVariable.new(:z)).to_s)

    expression =
      LCCall.new(
        LCCall.new(LCVariable.new(:x), LCVariable.new(:y)),
        LCFunction.new(:y, LCCall.new(LCVariable.new(:y), LCVariable.new(:x)))
      )
    assert_equal("x[y][-> y { y[x] }]", expression.to_s)
    assert_equal("z[y][-> y { y[z] }]", expression.replace(:x, LCVariable.new(:z)).to_s)
    # second `y` is function argument, so it must not be replaced.
    # and third `y` is variable that conform second.
    assert_equal("x[z][-> y { y[x] }]", expression.replace(:y, LCVariable.new(:z)).to_s)
  end

  def test_function_call
    function =
      LCFunction.new(:x,
                     LCFunction.new(:y,
                                    LCCall.new(LCVariable.new(:x), LCVariable.new(:y))))
    assert_equal("-> x { -> y { x[y] } }", function.to_s)
    argument = LCFunction.new(:z, LCVariable.new(:z))
    assert_equal("-> y { -> z { z }[y] }", function.call(argument).to_s)
  end

  def test_callable?
    v = LCVariable.new(:x)
    refute v.callable?

    f = LCFunction.new(:x, LCVariable.new(:x))
    assert f.callable?

    c = LCCall.new(LCVariable.new(:x), LCVariable.new(:y))
    refute c.callable?
  end

  def test_reduce
    expression = LCCall.new(LCCall.new(@add, @one), @one)
    while expression.reducible?
      expression = expression.reduce
    end
    # below return unexpected expression.
    # but if both of each behave same, they are equivalent.
    refute("-> p { -> x { p[p[x]] } }" == expression.to_s)

    inc, zero = LCVariable.new(:inc), LCVariable.new(:zero)
    expression = LCCall.new(LCCall.new(expression, inc), zero)
    assert_equal("-> p { -> x { p[-> p { -> x { p[x] } }[p][x]] } }[inc][zero]",
                 expression.to_s)
    while expression.reducible?
      expression = expression.reduce
    end
    assert_equal("inc[inc[zero]]", expression.to_s)
  end
end
