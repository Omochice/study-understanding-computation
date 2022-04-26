require "minitest/autorun"
require_relative "../../src/pushdown-automaton/deterministic-pushdown-automaton.rb"

class DPDARulebookTest < Minitest::Test
  def setup
    @rulebook = DPDARulebook.new([
      PDARule.new(1, "(", 2, "$", ["b", "$"]),
      PDARule.new(2, "(", 2, "b", ["b", "b"]),
      PDARule.new(2, ")", 2, "b", []),
      PDARule.new(2, nil, 1, "$", ["$"]),
    ])
  end

  def test_follow_free_moves
    configuration = PDAConfiguration.new(2, Stack.new(["$"]))
    expected = PDAConfiguration.new(1, Stack.new(["$"]))
    assert_equal(expected, @rulebook.follow_free_moves(configuration))
  end
end

class DPDATest < Minitest::Test
  def setup
    rulebook = DPDARulebook.new([
      PDARule.new(1, "(", 2, "$", ["b", "$"]),
      PDARule.new(2, "(", 2, "b", ["b", "b"]),
      PDARule.new(2, ")", 2, "b", []),
      PDARule.new(2, nil, 1, "$", ["$"]),
    ])
    @dpda = DPDA.new(PDAConfiguration.new(1, Stack.new(["$"])), [1], rulebook)
  end

  def test_read_string
    assert @dpda.accepting?

    @dpda.read_string("(()")
    refute @dpda.accepting?

    @dpda.read_string(")")
    assert @dpda.accepting?
    assert_equal(PDAConfiguration.new(1, Stack.new(["$"])), @dpda.current_configuration)
  end
end

class DPDADesignTest < Minitest::Test
  def setup
    rulebook = DPDARulebook.new([
      PDARule.new(1, "(", 2, "$", ["b", "$"]),
      PDARule.new(2, "(", 2, "b", ["b", "b"]),
      PDARule.new(2, ")", 2, "b", []),
      PDARule.new(2, nil, 1, "$", ["$"]),
    ])
    @dpda_design = DPDADesign.new(1, "$", [1], rulebook)
  end

  def test_accepts?
    assert @dpda_design.accepts?("((((((((()))))))))")
    assert @dpda_design.accepts?("(()()())")
    refute @dpda_design.accepts?("(((((((()))))))))")
    refute @dpda_design.accepts?("())")
  end
end
