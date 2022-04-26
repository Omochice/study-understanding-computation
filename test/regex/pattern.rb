require "minitest/autorun"
require "securerandom"
require_relative "../../src/regex/pattern.rb"

class EmptyTest < Minitest::Test
  def test_to_s
    empty = Empty.new
    assert_equal empty.to_s, ""
  end

  def test_precedence
    empty = Empty.new
    assert_equal empty.precedence, 3
  end

  def test_to_nfa_design
    nfa_design = Empty.new.to_nfa_design
    assert nfa_design.accepts?("")
    refute nfa_design.accepts?("a")
  end

  def test_matches?
    assert Empty.new.matches?("")
    refute Empty.new.matches?("a")
  end
end

class LiteralTest < Minitest::Test
  def test_to_s
    # Is 0 length string valid?
    100.times do |i|
      hex = SecureRandom.alphanumeric(i)
      literal = Literal.new(hex)
      assert_equal literal.to_s, hex
    end
  end

  def test_precedence
    100.times do |i|
      hex = SecureRandom.alphanumeric(i)
      literal = Literal.new(hex)
      assert_equal literal.precedence, 3
    end
  end

  def test_to_nfa_design
    nfa_design = Literal.new("a").to_nfa_design
    refute nfa_design.accepts?("")
    assert nfa_design.accepts?("a")
    refute nfa_design.accepts?("b")
  end

  def test_matches?
    refute Literal.new("a").matches?("")
    assert Literal.new("a").matches?("a")
    refute Literal.new("a").matches?("b")
  end
end

class ConcatenateTest < Minitest::Test
  def test_to_s
    100.times do
      first = SecureRandom.alphanumeric(1)
      second = SecureRandom.alphanumeric(1)
      actual = Concatenate.new(Literal.new(first), Literal.new(second)).to_s
      assert_equal("#{first}#{second}", actual)
    end
  end

  def test_inspect
    100.times do
      first = SecureRandom.alphanumeric(1)
      second = SecureRandom.alphanumeric(1)
      actual = Concatenate.new(Literal.new(first), Literal.new(second)).inspect
      assert_equal("/#{first}#{second}/", actual)
    end
  end

  def test_precedence
  end

  def test_to_nfa_design
    nfa_design = Concatenate.new(Literal.new("a"), Literal.new("b")).to_nfa_design
    refute nfa_design.accepts?("a")
    assert nfa_design.accepts?("ab")
    refute nfa_design.accepts?("abc")
  end

  def test_matches?
    concatenate = Concatenate.new(Literal.new("a"), Literal.new("b"))
    refute concatenate.matches?("a")
    assert concatenate.matches?("ab")
    refute concatenate.matches?("abc")
  end
end

class ChooseTest < Minitest::Test
  def test_to_s
    100.times do
      first = SecureRandom.alphanumeric(1)
      second = SecureRandom.alphanumeric(1)
      actual = Choose.new(Literal.new(first), Literal.new(second)).to_s
      assert_equal("#{first}|#{second}", actual)
    end
  end

  def test_inspect
    100.times do
      first = SecureRandom.alphanumeric(1)
      second = SecureRandom.alphanumeric(1)
      actual = Choose.new(Literal.new(first), Literal.new(second)).inspect
      assert_equal("/#{first}|#{second}/", actual)
    end
  end

  def test_precedence
  end

  def test_to_nfa_design
    nfa_design = Choose.new(Literal.new("a"), Literal.new("b")).to_nfa_design
    assert nfa_design.accepts?("a")
    assert nfa_design.accepts?("b")
    refute nfa_design.accepts?("c")
  end

  def test_matches?
    choose = Choose.new(Literal.new("a"), Literal.new("b"))
    assert choose.matches?("a")
    assert choose.matches?("b")
    refute choose.matches?("c")
  end
end

class RepeatTest < Minitest::Test
  def test_to_s
    100.times do
      char = SecureRandom.alphanumeric(1)
      actual = Repeat.new(Literal.new(char)).to_s
      assert_equal("#{char}*", actual)
    end
  end

  def test_inspect
    100.times do
      char = SecureRandom.alphanumeric(1)
      actual = Repeat.new(Literal.new(char)).inspect
      assert_equal("/#{char}*/", actual)
    end
  end

  def test_precedence
  end

  def test_to_nfa_design
    nfa_design = Repeat.new(Literal.new("a")).to_nfa_design
    assert nfa_design.accepts?("")
    assert nfa_design.accepts?("a")
    assert nfa_design.accepts?("aa")
    assert nfa_design.accepts?("aaa")
    refute nfa_design.accepts?("aaab")
  end
end

class MixinTest < Minitest::Test
  def test_mixin
    pattern = Repeat.new(
      Concatenate.new(
        Literal.new("a"),
        Choose.new(Empty.new, Literal.new("b"))
      )
    )
    assert_equal("/(a(|b))*/", pattern.inspect)
    assert pattern.matches?("")
    assert pattern.matches?("a")
    assert pattern.matches?("ab")
    assert pattern.matches?("aba")
    assert pattern.matches?("abab")
    assert pattern.matches?("abaab")
    refute pattern.matches?("abba")
  end
end
