require "minitest/autorun"
require_relative "../../src/turing-machine/tape.rb"

class TapeTest < Minitest::Test
  def setup
    @tape = Tape.new(["1", "0", "1"], "1", [], "_")
  end

  def test_write
    assert_equal("0", @tape.write("0").middle)
  end

  def test_move_head_left
    assert_equal("1", @tape.move_head_left.middle)
  end

  def test_move_head_right
    assert_equal("_", @tape.move_head_right.middle)
  end
end
