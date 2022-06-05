require "minitest/autorun"
require_relative "../../src/universality/tag-system.rb"

class TagSystemTest < Minitest::Test
  def test_step
    rulebook = TagRuleBook.new(2, [TagRule.new("a", "aa"), TagRule.new("b", "bbbb")])
    system = TagSystem.new("aabbbbbb", rulebook)
    expecteds = [
      "bbbbbbaa",
      "bbbbaabbbb",
      "bbaabbbbbbbb",
      "aabbbbbbbbbbbb",
    ]
    assert_equal("aabbbbbb", system.current_string)
    4.times do |i|
      system.step
      assert_equal(expecteds[i], system.current_string)
    end
  end
end
