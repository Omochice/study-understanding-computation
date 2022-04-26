require "minitest/autorun"
require_relative "../../src/finite-automaton/dfa.rb"

class DFARuleBookTest < Minitest::Test
  def setup
    @rulebook = DFARuleBook.new([
      FARule.new(1, "a", 2), FARule.new(1, "b", 1),
      FARule.new(2, "a", 2), FARule.new(2, "b", 3),
      FARule.new(3, "a", 3), FARule.new(3, "b", 3),
    ])
  end

  def test_by_book
    assert_equal(2, @rulebook.next_state(1, "a"))
    assert_equal(1, @rulebook.next_state(1, "b"))
    assert_equal(3, @rulebook.next_state(2, "b"))
  end
end

class DFATest < Minitest::Test
  def setup
    @rulebook = DFARuleBook.new([
      FARule.new(1, "a", 2), FARule.new(1, "b", 1),
      FARule.new(2, "a", 2), FARule.new(2, "b", 3),
      FARule.new(3, "a", 3), FARule.new(3, "b", 3),
    ])
  end

  def test_read_character
    dfa = DFA.new(1, [3], @rulebook)
    refute dfa.accepting?

    dfa.read_character("b")
    refute dfa.accepting?

    3.times { dfa.read_character("a") }
    refute dfa.accepting?

    dfa.read_character("b")
    assert dfa.accepting?
  end

  def test_read_string
    dfa = DFA.new(1, [3], @rulebook)
    refute dfa.accepting?

    dfa.read_string("baaab")
    assert dfa.accepting?
  end
end

class DFADesignTest < Minitest::Test
  def setup
    @rulebook = DFARuleBook.new([
      FARule.new(1, "a", 2), FARule.new(1, "b", 1),
      FARule.new(2, "a", 2), FARule.new(2, "b", 3),
      FARule.new(3, "a", 3), FARule.new(3, "b", 3),
    ])
  end

  def test_accepts?
    dfa_design = DFADesign.new(1, [3], @rulebook)
    refute dfa_design.accepts?("a")
    refute dfa_design.accepts?("baa")
    assert dfa_design.accepts?("baba")
  end
end
