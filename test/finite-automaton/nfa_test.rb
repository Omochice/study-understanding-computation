require "minitest/autorun"
require "set"
require_relative "../../src/finite-automaton/nfa.rb"

class NFARulebookTest < Minitest::Test
  def setup
    @rulebook = NFARulebook.new([
      FARule.new(1, "a", 1), FARule.new(1, "b", 1), FARule.new(1, "b", 2),
      FARule.new(2, "a", 3), FARule.new(2, "b", 3),
      FARule.new(3, "a", 4), FARule.new(3, "b", 4),
    ])
  end

  def test_next_states
    actual = @rulebook.next_states(Set[1], "b")
    assert_equal(Set[1, 2], actual)

    actual = @rulebook.next_states(Set[1, 2], "a")
    assert_equal(Set[1, 3], actual)

    actual = @rulebook.next_states(Set[1, 3], "b")
    assert_equal(Set[1, 2, 4], actual)
  end

  def test_free_move
    rulebook = NFARulebook.new([
      FARule.new(1, nil, 2), FARule.new(1, nil, 4),
      FARule.new(2, "a", 3),
      FARule.new(3, "a", 4),
      FARule.new(4, "a", 5),
      FARule.new(5, "a", 6),
      FARule.new(6, "a", 4),
    ])
    assert_equal(Set[2, 4], rulebook.next_states(Set[1], nil))
    assert_equal(Set[1, 2, 4], rulebook.follow_free_moves(Set[1]))
  end

  def alphabet
    assert_equal(Set(["a", "b"]), Set(@rulebook.alphabet))
  end
end

class NFATest < Minitest::Test
  def setup
    rulebook = NFARulebook.new([
      FARule.new(1, "a", 1), FARule.new(1, "b", 1), FARule.new(1, "b", 2),
      FARule.new(2, "a", 3), FARule.new(2, "b", 3),
      FARule.new(3, "a", 4), FARule.new(3, "b", 4),
    ])
    @nfa = NFA.new(Set[1], [4], rulebook)
  end

  def test_read_character
    refute @nfa.accepting?

    @nfa.read_character("b")
    refute @nfa.accepting?

    @nfa.read_character("a")
    refute @nfa.accepting?

    @nfa.read_character("b")
    assert @nfa.accepting?
  end

  def test_read_string
    refute @nfa.accepting?

    @nfa.read_string("bbbbb")
    assert @nfa.accepting?
  end
end

class NFADesignTest < Minitest::Test
  def setup
    rulebook = NFARulebook.new([
      FARule.new(1, "a", 1), FARule.new(1, "b", 1), FARule.new(1, "b", 2),
      FARule.new(2, "a", 3), FARule.new(2, "b", 3),
      FARule.new(3, "a", 4), FARule.new(3, "b", 4),
    ])
    @nfa_design = NFADesign.new(1, [4], rulebook)
  end

  def test_accepts
    assert @nfa_design.accepts?("bab")
    assert @nfa_design.accepts?("bbbbb")
    refute @nfa_design.accepts?("bbabb")
  end
end

class NFASimulationTest < Minitest::Test
  def setup
    rulebook = NFARulebook.new([
      FARule.new(1, "a", 1), FARule.new(1, "a", 2), FARule.new(1, nil, 2),
      FARule.new(2, "b", 3),
      FARule.new(3, "b", 1), FARule.new(3, nil, 2),
    ])
    nfa_design = NFADesign.new(1, [3], rulebook)
    @simulation = NFASimulation.new(nfa_design)
  end

  def test_next_state
    assert_equal(Set[1, 2], @simulation.next_state(Set[1, 2], "a"))
    assert_equal(Set[2, 3], @simulation.next_state(Set[1, 2], "b"))
    assert_equal(Set[1, 2, 3], @simulation.next_state(Set[2, 3], "b"))
    assert_equal(Set[1, 2, 3], @simulation.next_state(Set[2, 3], "b"))
    assert_equal(Set[1, 2], @simulation.next_state(Set[1, 2, 3], "a"))
  end

  def test_rules_for
    expected = Set.new([FARule.new(Set[1, 2], "a", Set[1, 2]),
                        FARule.new(Set[1, 2], "b", Set[2, 3])])
    actual = Set.new(@simulation.rules_for(Set[1, 2]))
    assert_equal(expected, actual)

    expected = Set.new([FARule.new(Set[3, 2], "a", Set[]),
                        FARule.new(Set[3, 2], "b", Set[1, 2, 3])])
    actual = Set.new(@simulation.rules_for(Set[3, 2]))
    assert_equal(expected, actual)
  end

  def test_to_dfa_design
    dfa_design = @simulation.to_dfa_design
    refute dfa_design.accepts?("aaa")
    assert dfa_design.accepts?("aab")
    assert dfa_design.accepts?("bbbabb")
  end
end
