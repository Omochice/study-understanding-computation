require "minitest/autorun"
require_relative "../../src/lambda/numbers.rb"
require_relative "../../src/lambda/operators.rb"
require_relative "./helper.rb"

class OperatorTest < Minitest::Test
  def test_increment
    assert_equal(1, to_integer(INCREMENT[ZERO]))
    assert_equal(2, to_integer(INCREMENT[ONE]))
    assert_equal(101, to_integer(INCREMENT[HANDRED]))
  end

  def test_decrement
    assert_equal(0, to_integer(DECREMENT[ONE]))
    assert_equal(1, to_integer(DECREMENT[TWO]))
    # Negative number is not defined.
    # so, the test below will be failed
    # puts to_integer(DECREMENT[ZERO])
    # assert_equal(-1, to_integer(DECREMENT[ZERO]))
    assert_equal(0, to_integer(DECREMENT[ZERO]))
  end

  def test_add
    assert_equal(0, to_integer(ADD[ZERO][ZERO]))
    assert_equal(1, to_integer(ADD[ONE][ZERO]))
    assert_equal(6, to_integer(ADD[ONE][FIVE]))
    assert_equal(115, to_integer(ADD[HANDRED][FIFTEEN]))
  end

  def test_substract
    assert_equal(0, to_integer(SUBSTRACT[ONE][ONE]))
    assert_equal(1, to_integer(SUBSTRACT[ONE][ZERO]))
    assert_equal(99, to_integer(SUBSTRACT[HANDRED][ONE]))
  end

  def test_multiply
    # number * 1 = number
    assert_equal(1, to_integer(MULTIPLY[ONE][ONE]))
    assert_equal(100, to_integer(MULTIPLY[HANDRED][ONE]))
    # number * 0 = 0
    assert_equal(0, to_integer(MULTIPLY[ONE][ZERO]))
    # multiply is commutative
    assert_equal(to_integer(MULTIPLY[TWO][THREE]),
                 to_integer(MULTIPLY[THREE][TWO]))
  end

  def test_to_div
    assert_equal(1, to_integer(DIV[FIVE][FIVE]))
    # 0 / Num = 0
    assert_equal(0, to_integer(DIV[ZERO][FIVE]))
    # num / 0 = NaN(raise error)
    assert_raises(SystemStackError) { to_integer(DIV[ONE][ZERO]) }
    # 0 / 0 = what??
    assert_raises(SystemStackError) { to_integer(DIV[ZERO][ZERO]) }
  end

  def test_mod
    # normal
    assert_equal(2, to_integer(MOD[FIVE][THREE]))
    assert_equal(0, to_integer(MOD[FIVE][FIVE]))
    assert_equal(5, to_integer(MOD[FIVE][FIFTEEN]))
  end

  def test_power
    # normal
    assert_equal(8, to_integer(POWER[TWO][THREE]))
    assert_equal(3125, to_integer(POWER[FIVE][FIVE])) # this is little slow
    # power is not commutative
    refute (to_integer(POWER[TWO][THREE]) \
             == to_integer(POWER[THREE][TWO]))
    # number ^ 0 is 1
    assert_equal(1, to_integer(POWER[THREE][ZERO]))
  end
end
