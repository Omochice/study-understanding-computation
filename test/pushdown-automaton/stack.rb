require "minitest/autorun"
require_relative "../../src/pushdown-automaton/stack.rb"

class StackTest < Minitest::Test
  def setup
    @stack = Stack.new(["a", "b", "c", "d", "e"])
  end

  def test_top
    assert_equal("a", @stack.top)
  end

  def test_pop
    assert_equal("c", @stack.pop.pop.top)
  end

  def test_push
    assert_equal("y", @stack.push("x").push("y").top)
  end

  def test_mixin
    assert_equal("a", @stack.top)
    assert_equal("c", @stack.pop.pop.top)
    assert_equal("y", @stack.push("x").push("y").top)
    assert_equal("x", @stack.push("x").push("y").pop.top)
  end
end
