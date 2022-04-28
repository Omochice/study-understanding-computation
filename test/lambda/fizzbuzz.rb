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
end

class OperatorTest < Minitest::Test
  def test_increment
    assert_equal(1, to_integer(INCREMENT[ZERO]))
    assert_equal(2, to_integer(INCREMENT[ONE]))
    assert_equal(101, to_integer(INCREMENT[HANDRED]))
  end
end
