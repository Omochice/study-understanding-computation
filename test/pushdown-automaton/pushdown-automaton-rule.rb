require "minitest/autorun"
require_relative "../../src/pushdown-automaton/stack.rb"
require_relative "../../src/pushdown-automaton/pushdown-automaton-rule.rb"

class PDARuleTest < Minitest::Test
  def setup
    @rule = PDARule.new(1, "(", 2, "$", ["b", "$"])
    @configuration = PDAConfiguration.new(1, Stack.new(["$"]))
  end

  def test_applies_to?
    assert @rule.applies_to?(@configuration, "(")
  end

  def test_follow
    expected = PDAConfiguration.new(2, Stack.new(["b", "$"]))
    assert_equal(expected, @rule.follow(@configuration))
  end
end
