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
                 to_array(UPWARDS_OF[ZERO], 5).map { |e| to_integer(e) })
    assert_equal((15...15 + 20).to_a,
                 to_array(UPWARDS_OF[FIFTEEN], 20).map { |e| to_integer(e) })
  end

  def test_multiples_of
    assert_equal((1...1 + 10).map { |e| e * 2 },
                 to_array(MULTIPLES_OF[TWO], 10).map { |e| to_integer(e) })
    assert_equal((1...1 + 20).map { |e| e * 5 },
                 to_array(MULTIPLES_OF[FIVE], 20).map { |e| to_integer(e) })
    # map procs
    assert_equal((1...1 + 10).map { |e| e * 3 + 1 },
                 to_array(MAP[MULTIPLES_OF[THREE]][INCREMENT], 10).map { |e| to_integer(e) })
    assert_equal((1...1 + 10).map { |e| e * 3 * 2 },
                 to_array(MAP[MULTIPLES_OF[THREE]][MULTIPLY[TWO]], 10).map { |e| to_integer(e) })
  end

  def test_multiply_stream
    assert_equal((1...1 + 10).zip((1..1 + 10).map { |e| e * 3 }).map { |x, y| x * y },
                 to_array(MULTIPLY_STREAMS[UPWARDS_OF[ONE]][MULTIPLES_OF[THREE]], 10)
      .map { |e| to_integer(e) })
  end
end
