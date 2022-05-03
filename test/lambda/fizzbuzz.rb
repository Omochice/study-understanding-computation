require "minitest/autorun"
require_relative "../../src/lambda/fizzbuzz.rb"
require_relative "./helper.rb"

class FizzBuzzTest < Minitest::Test
  def setup
    def fizzbuzz(s, e)
      (s..e).map do |n|
        if (n % 15).zero?
          "FizzBuzz"
        elsif (n % 3).zero?
          "Fizz"
        elsif (n % 5).zero?
          "Buzz"
        else
          n.to_s
        end
      end
    end

    @expecteds = fizzbuzz(1, 100)
  end

  def test_solution
    to_array(SOLUTION).zip(@expecteds).each do |actual, expected|
      assert_equal(expected, to_string(actual))
    end
  end
end
