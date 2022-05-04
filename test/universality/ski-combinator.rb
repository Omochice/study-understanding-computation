require "minitest/autorun"
require_relative "../../src/universality/ski-combinator.rb"

class SKISymbolTest < Minitest::Test
  def setup
    @symbol = SKISymbol.new(:A)
  end

  def test_to_s
    assert_equal("A", @symbol.to_s)
  end

  def test_inspect
    assert_equal("A", @symbol.to_s)
  end
end

class SKICallTest < Minitest::Test
  def setup
    @expression = SKICall.new(SKICall.new(S, K), SKICall.new(I, SKISymbol.new(:x)))
  end

  def test_to_s
    assert_equal("S[K][I[x]]", @expression.to_s)
  end

  def test_inspect
    assert_equal("S[K][I[x]]", @expression.to_s)
  end
end

class SKICombinatorTest < Minitest::Test
  def setup
  end

  def test_to_s
  end

  def test_inspect
  end
end
