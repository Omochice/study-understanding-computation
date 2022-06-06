require "minitest/autorun"
require_relative "../../src/universality/cyclic-tag-system.rb"

class CyclicTagRuleBookTest < Minitest::Test
  def test_current_string
    rulebook = CyclicTagRuleBook.new([
      CyclicTagRule.new("1"), CyclicTagRule.new("0010"), CyclicTagRule.new("10"),
    ])
    system = TagSystem.new("11", rulebook)
    expecteds = [
      "11",
      "11",
      "10010",
      "001010",
      "01010",
      "1010",
      "01010",
      "1010",
      "0100010",
      "100010",
      "000101",
      "00101",
      "0101",
      "101",
      "010010",
      "10010",
      "00101",
    ]
    16.times do
      assert_equal(expecteds.shift, system.current_string)
      system.step
    end
    assert_equal(expecteds.shift, system.current_string)
  end
end

class CyclicTagEncoderTest < Minitest::Test
  def test_encode_character
    encoder = CyclicTagEncoder.new(["a", "b", "c", "d"])
    assert_equal("0010", encoder.encode_character("c"))
  end

  def test_encode_string
    encoder = CyclicTagEncoder.new(["a", "b", "c", "d"])
    assert_equal("001010000100", encoder.encode_string("cab"))
  end
end

class TagRuleTest < Minitest::Test
  def test_to_cyclic
    encoder = CyclicTagEncoder.new(["a", "b", "c", "d"])
    rule = TagRule.new("a", "ccdd")
    expected = CyclicTagRule.new("0010001000010001")
    assert_equal(expected, rule.to_cyclic(encoder))
  end
end
