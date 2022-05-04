require "minitest/autorun"
require_relative "../../src/lambda/numbers.rb"
require_relative "../../src/universality/tape.rb"
require_relative "../lambda/helper.rb"

class TapeTest < Minitest::Test
  def test_write_numbers
    current_tape = TAPE[EMPTY][ZERO][EMPTY][ZERO]
    expected = []
    [ONE, TWO, THREE].each do |num|
      current_tape = TAPE_WRITE[current_tape][num]
      current_tape = TAPE_MOVE_HEAD_RIGHT[current_tape]
      expected << to_integer(num)
      assert_equal(expected, to_array(TAPE_LEFT[current_tape]).map { |e| to_integer(e) })
    end
    assert_equal(0, to_integer(TAPE_MIDDLE[current_tape]))
    assert to_array(TAPE_RIGHT[current_tape]).map { |e| to_integer(e) }.empty?
  end
end
