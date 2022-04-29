require "minitest/autorun"
require_relative "../../src/lambda/fizzbuzz.rb"

class ConstantTest < Minitest::Test
  def test_one
    assert_equal(1, to_integer(ONE))
  end

  def test_two
    assert_equal(2, to_integer(TWO))
  end

  def test_three
    assert_equal(3, to_integer(THREE))
  end

  def test_fifteen
    assert_equal(15, to_integer(FIFTEEN))
  end

  def test_handred
    assert_equal(100, to_integer(HANDRED))
  end
end

class BooleanTest < Minitest::Test
  def test_true
    assert to_boolean(TRUE)
  end

  def test_false
    refute to_boolean(FALSE)
  end
end

class StatementTest < Minitest::Test
  def test_if
    assert_equal("expected", IF[TRUE]["expected"]["not expected"])
    assert_equal("expected", IF[FALSE]["not expected"]["expected"])
  end

  def test_is_zero
    assert to_boolean(IS_ZERO[ZERO])
    refute to_boolean(IS_ZERO[ONE])
    refute to_boolean(IS_ZERO[TWO])
    refute to_boolean(IS_ZERO[THREE])
  end

  def test_pair
    pair = PAIR[THREE][FIVE]
    assert_equal(3, to_integer(LEFT[pair]))
    assert_equal(5, to_integer(RIGHT[pair]))
  end

  def test_is_less_or_equal
    refute to_boolean(IS_LESS_OR_EQUAL[TWO][ONE])
    assert to_boolean(IS_LESS_OR_EQUAL[TWO][TWO])
    assert to_boolean(IS_LESS_OR_EQUAL[TWO][THREE])
  end
end

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
