require "minitest/autorun"
require_relative "../../src/lambda/numbers.rb"
require_relative "../../src/lambda/strings.rb"
require_relative "./helper.rb"

class StringTest < Minitest::Test
  def test_to_char
    assert_equal("z", to_char(ZED))
  end

  def test_to_string
    assert_equal("Fizz", to_string(FIZZ))
    assert_equal("Buzz", to_string(BUZZ))
    assert_equal("FizzBuzz", to_string(FIZZBUZZ))
  end

  def test_to_digits
    assert_equal([5],
                 to_array(TO_DIGITS[FIVE]).map { |e| to_integer(e) })
    assert_equal((5 ** 3).to_s.split("").map(&:to_i),
                 to_array(TO_DIGITS[POWER[FIVE][THREE]]).map { |e| to_integer(e) })
  end
end
