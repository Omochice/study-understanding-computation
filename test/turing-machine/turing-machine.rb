require "minitest/autorun"
require_relative "../../src/turing-machine/tape.rb"
require_relative "../../src/turing-machine/turing-machine.rb"

class TMRuleTest < Minitest::Test
  def setup
    @rule = TMRule.new(1, "0", 2, "1", :right)
  end

  def test_applies_to?
    assert @rule.applies_to?(TMConfiguration.new(1, Tape.new([], "0", [], "_")))
    refute @rule.applies_to?(TMConfiguration.new(1, Tape.new([], "1", [], "_")))
    refute @rule.applies_to?(TMConfiguration.new(2, Tape.new([], "0", [], "_")))
  end

  def test_follow
    expected = TMConfiguration.new(2, Tape.new(["1"], "_", [], "_"))
    assert_equal(expected, @rule.follow(TMConfiguration.new(1, Tape.new([], "0", [], "_"))))
  end
end
