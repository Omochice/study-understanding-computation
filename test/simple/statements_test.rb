require "minitest/autorun"
require_relative "../../src/simple/statements.rb"

class DoNothingTest < Minitest::Test
  def test_to_s
    state = DoNothing.new
    assert_equal("do-nothing", state.to_s)
  end

  def test_inspect
    state = DoNothing.new
    assert_equal("<<do-nothing>>", state.inspect)
  end

  def test_equal
    state = DoNothing.new
    assert_instance_of(DoNothing, state)
  end

  def test_reducible
    state = DoNothing.new
    refute(state.reducible?)
  end
end
