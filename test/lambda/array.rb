require "minitest/autorun"
require_relative "../../src/lambda/array.rb"
require_relative "../../src/lambda/numbers.rb"
require_relative "../../src/lambda/operators.rb"
require_relative "./helper.rb"

class ArrayTest < Minitest::Test
  def setup
    @list = UNSHIFT[
      UNSHIFT[
        UNSHIFT[EMPTY][THREE]
      ][TWO]
    ][ONE]
  end

  def test_pair
    pair = PAIR[THREE][FIVE]
    assert_equal(3, to_integer(LEFT[pair]))
    assert_equal(5, to_integer(RIGHT[pair]))
  end

  def test_to_array
    assert_equal([1, 2, 3], to_array(@list).map { |e| to_integer(e) })
  end

  def test_first
    assert_equal(1, to_integer(FIRST[@list]))
    assert_equal(2, to_integer(FIRST[REST[@list]]))
    assert_equal(3, to_integer(FIRST[REST[REST[@list]]]))
  end

  def test_countdown
    start = 15
    pair = PAIR[EMPTY][FIFTEEN]
    expected = []
    start.times do |i|
      expected = [start - i] + expected
      pair = COUNTDOWN[pair]
      assert_equal(expected,
                   to_array(LEFT[pair]).map { |e| to_integer(e) })
      assert_equal(start - i - 1,
                   to_integer(RIGHT[pair]))
    end
  end

  def test_range
    assert_equal((1..5).to_a, to_array(RANGE[ONE][FIVE]).map { |e| to_integer(e) })
    assert_equal((5..1).to_a, to_array(RANGE[FIVE][ONE]).map { |e| to_integer(e) })
  end

  def test_fold
    assert_equal((1..5).inject(0, :+), to_integer(FOLD[RANGE[ONE][FIVE]][ZERO][ADD]))
    assert_equal((1..5).inject(0, :*), to_integer(FOLD[RANGE[ONE][FIVE]][ZERO][MULTIPLY]))
  end

  def test_map
    assert_equal((0..5).map { |e| e + 1 },
                 to_array(MAP[RANGE[ZERO][FIVE]][INCREMENT]).map { |e| to_integer(e) })
  end

  def test_push
    assert_equal([1, 2, 3].push(1),
                 to_array(PUSH[@list][ONE]).map { |e| to_integer(e) })
  end
end
