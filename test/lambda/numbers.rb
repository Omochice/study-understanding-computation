require "minitest/autorun"
require_relative "./helper.rb"
require_relative "../../src/lambda/numbers.rb"

class NumbersTest < Minitest::Test
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
