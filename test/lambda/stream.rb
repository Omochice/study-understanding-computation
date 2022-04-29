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
end
