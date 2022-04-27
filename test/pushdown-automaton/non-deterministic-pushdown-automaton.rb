require "minitest/autorun"
require_relative "../../src/pushdown-automaton/non-deterministic-pushdown-automaton-rule.rb"

class NPDARulebookTest
end

class NPDATest
  def setup
    rulebook = NPDARulebook.new([
      PDARule.new(1, "a", 1, "$", ["a", "$"]),
      PDARule.new(1, "a", 1, "a", ["a", "a"]),
      PDARule.new(1, "a", 1, "b", ["a", "b"]),
      PDARule.new(1, "b", 1, "$", ["b", "$"]),
      PDARule.new(1, "b", 1, "a", ["b", "a"]),
      PDARule.new(1, "b", 1, "b", ["b", "b"]),
      PDARule.new(1, nil, 2, "$", ["$"]),
      PDARule.new(1, nil, 2, "a", ["a"]),
      PDARule.new(1, nil, 2, "b", ["b"]),
      PDARule.new(2, "a", 2, "a", []),
      PDARule.new(2, "b", 2, "b", []),
      PDARule.new(2, nil, 3, "$", []),
    ])
    configuration = PDAConfiguration.new(1, Stack.new)
    @npda = NPDA.new(Set[configuration], [3], rulebook)
  end

  def test_read_string?
    assert @npda.accepting?

    @npda.read_string("abb")
    refute @npda.accepting?

    @npda.read_string("a")
    assert @npda.accepting?
  end
end

class NPDADesignTest < Minitest::Test
  def setup
    rulebook = NPDARulebook.new([
      PDARule.new(1, "a", 1, "$", ["a", "$"]),
      PDARule.new(1, "a", 1, "a", ["a", "a"]),
      PDARule.new(1, "a", 1, "b", ["a", "b"]),
      PDARule.new(1, "b", 1, "$", ["b", "$"]),
      PDARule.new(1, "b", 1, "a", ["b", "a"]),
      PDARule.new(1, "b", 1, "b", ["b", "b"]),
      PDARule.new(1, nil, 2, "$", ["$"]),
      PDARule.new(1, nil, 2, "a", ["a"]),
      PDARule.new(1, nil, 2, "b", ["b"]),
      PDARule.new(2, "a", 2, "a", []),
      PDARule.new(2, "b", 2, "b", []),
      PDARule.new(2, nil, 3, "$", []),
    ])
    @npda_design = NPDADesign.new(1, "$", [3], rulebook)
  end

  def test_accepts?
    assert @npda_design.accepts?("abba")
    assert @npda_design.accepts?("babbaabbab")
    refute @npda_design.accepts?("abb")
    refute @npda_design.accepts?("baabaa")
  end
end
