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

  def test_run
    rulebook = TagRuleBook.new(2, [TagRule.new("a", "cc"), TagRule.new("b", "dddd")])
    system = TagSystem.new("aabbbbbb", rulebook)
    expecteds = [
      "aabbbbbb",
      "bbbbbbcc",
      "bbbbccdddd",
      "bbccdddddddd",
      "ccdddddddddddd",
    ]
    system.run do |actual|
      assert_equal(expecteds.shift, actual)
    end
  end

  def test_divide
    rulebook = TagRuleBook.new(2, [TagRule.new("a", "cc"), TagRule.new("b", "d")])
    system = TagSystem.new("aabbbbbbbbbbbb", rulebook)
    expecteds = [
      "aabbbbbbbbbbbb",
      "bbbbbbbbbbbbcc",
      "bbbbbbbbbbccd",
      "bbbbbbbbccdd",
      "bbbbbbccddd",
      "bbbbccdddd",
      "bbccddddd",
      "ccdddddd",
    ]
    system.run do |actual|
      assert_equal(expecteds.shift, actual)
    end
  end

  def test_increment
    rulebook = TagRuleBook.new(2, [TagRule.new("a", "ccdd"), TagRule.new("b", "dd")])
    system = TagSystem.new("aabbbb", rulebook)
    expecteds = [
      "aabbbb",
      "bbbbccdd",
      "bbccdddd",
      "ccdddddd",
    ]
    system.run do |actual|
      assert_equal(expecteds.shift, actual)
    end
  end

  def test_united_system
    rulebook = TagRuleBook.new(2, [
      TagRule.new("a", "cc"), TagRule.new("b", "dddd"),
      TagRule.new("c", "eeff"), TagRule.new("d", "ff"),
    ])
    system = TagSystem.new("aabbbb", rulebook)
    expecteds = [
      "aabbbb",
      "bbbbcc",
      "bbccdddd",
      "ccdddddddd",
      "ddddddddeeff",
      "ddddddeeffff",
      "ddddeeffffff",
      "ddeeffffffff",
      "eeffffffffff",
    ]
    system.run do |actual|
      assert_equal(expecteds.shift, actual)
    end
  end

  def test_tagsystem_that_decide_is_number_odd_or_not
    rulebook = TagRuleBook.new(2, [
      TagRule.new("a", "cc"), TagRule.new("b", "d"),
      TagRule.new("c", "eo"), TagRule.new("d", ""),
      TagRule.new("e", "e"),
    ])
    # if receive string show even, return "e" finally
    system = TagSystem.new("aabbbbbbbb", rulebook)
    expecteds = [
      "aabbbbbbbb",
      "bbbbbbbbcc",
      "bbbbbbccd",
      "bbbbccdd",
      "bbccddd",
      "ccdddd",
      "ddddeo",
      "ddeo",
      "eo",
      "e",
    ]
    system.run do |actual|
      assert_equal(expecteds.shift, actual)
    end

    # if receive string show odd, return "o" finally
    system = TagSystem.new("aabbbbbbbbbb", rulebook)
    expecteds = [
      "aabbbbbbbbbb",
      "bbbbbbbbbbcc",
      "bbbbbbbbccd",
      "bbbbbbccdd",
      "bbbbccddd",
      "bbccdddd",
      "ccddddd",
      "dddddeo",
      "dddeo",
      "deo",
      "o",
    ]
    system.run do |actual|
      assert_equal(expecteds.shift, actual)
    end
  end

  def test_alphabet
    rulebook = TagRuleBook.new(2, [
      TagRule.new("a", "ccdd"), TagRule.new("b", "dd"),
    ])
    system = TagSystem.new("aabbbb", rulebook)
    assert_equal(["a", "b", "c", "d"], system.alphabet)
  end
end
