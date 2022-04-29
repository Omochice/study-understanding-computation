require "minitest/autorun"
require_relative "../../src/lambda/array.rb"
require_relative "../../src/lambda/numbers.rb"
require_relative "../../src/lambda/stream.rb"
require_relative "./helper.rb"

class Stream < Minitest::Test
  def test_zeros
    zeros = ZEROS
    10.times do
      assert_equal(0, to_integer(FIRST[ZEROS]))
      zeros = REST[ZEROS]
    end
  end

  def test_upwards_of
    assert_equal((0...0 + 5).to_a,
                 to_array(UPWARD_OF[ZERO], 5).map { |e| to_integer(e) })
    assert_equal((15...15 + 20).to_a,
                 to_array(UPWARD_OF[FIFTEEN], 20).map { |e| to_integer(e) })
  end

  def test_multiply_of
    assert((2...2 + 10).map { |e| e * 2 },
           to_array(MULTIPLY_OF[TWO], 10).map { |e| to_integer(e) })
    assert((5...5 + 20).map { |e| e * 2 },
           to_array(MULTIPLY_OF[FIVE], 20).map { |e| to_integer(e) })
  end
end
