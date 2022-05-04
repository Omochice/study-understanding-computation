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

class STest < Minitest::Test
  def setup
    @x = SKISymbol.new(:x)
    @y = SKISymbol.new(:y)
    @z = SKISymbol.new(:z)
  end

  def test_call
    assert_equal("x[z][y[z]]", S.call(@x, @y, @z).to_s)
  end

  def test_left_right
    expression = SKICall.new(SKICall.new(SKICall.new(S, @x), @y), @z)
    combinator = expression.left.left.left
    assert_equal("S", combinator.to_s)

    first_arg = expression.left.left.right
    assert_equal("x", first_arg.to_s)

    second_arg = expression.left.right
    assert_equal("y", second_arg.to_s)

    third_arg = expression.right
    assert_equal("z", third_arg.to_s)
  end
end
