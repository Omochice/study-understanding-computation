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
    @x = SKISymbol.new(:x)
    @y = SKISymbol.new(:y)
    @z = SKISymbol.new(:z)
    @expression = SKICall.new(SKICall.new(S, K), SKICall.new(I, @x))
  end

  def test_to_s
    assert_equal("S[K][I[x]]", @expression.to_s)
  end

  def test_inspect
    assert_equal("S[K][I[x]]", @expression.to_s)
  end

  def test_callable?
    expression = SKICall.new(SKICall.new(@x, @y), @z)
    refute expression.combinator.callable?(*expression.arguments)

    expression = SKICall.new(SKICall.new(S, @x), @y)
    refute expression.combinator.callable?(*expression.arguments)

    expression = SKICall.new(SKICall.new(SKICall.new(S, @x), @y), @z)
    assert expression.combinator.callable?(*expression.arguments)
  end

  def test_reduce
    swap = SKICall.new(SKICall.new(S, SKICall.new(K, SKICall.new(S, I))), K)
    expression = SKICall.new(SKICall.new(swap, @x), @y)
    # puts expression.reducible?
    expecteds = [
      "S[K[S[I]]][K][x][y]",
      "K[S[I]][x][K[x]][y]",
      "S[I][K[x]][y]",
      "I[y][K[x][y]]",
      "y[K[x][y]]",
      "y[x]",
    ]
    while expression.reducible?
      expected = expecteds.shift
      assert_equal(expected, expression.to_s)
      expression = expression.reduce
    end
  end

  def test_as_a_function_of
    original = SKICall.new(SKICall.new(S, K), I)
    assert_equal("S[K][I]", original.to_s)
    function = original.as_a_function_of(:x)
    assert_equal("S[S[K[S]][K[K]]][K[I]]", function.to_s)
    refute function.reducible?

    expression = SKICall.new(function, @y)
    assert_equal("S[S[K[S]][K[K]]][K[I]][y]", expression.to_s)
    expecteds = [
      "S[S[K[S]][K[K]]][K[I]][y]",
      "S[K[S]][K[K]][y][K[I][y]]",
      "K[S][y][K[K][y]][K[I][y]]",
      "S[K[K][y]][K[I][y]]",
      "S[K][K[I][y]]",
      "S[K][I]",
    ]
    assert expression.reducible?
    while expression.reducible?
      expected = expecteds.shift
      assert_equal(expected, expression.to_s)
      expression = expression.reduce
    end

    assert_equal(original, expression)
  end

  def test_as_a_function_of_include_name
    original = SKICall.new(SKICall.new(S, @x), I)
    assert_equal("S[x][I]", original.to_s)
    function = original.as_a_function_of(:x)
    assert_equal("S[S[K[S]][I]][K[I]]", function.to_s)
    expression = SKICall.new(function, @y)
    assert_equal("S[S[K[S]][I]][K[I]][y]", expression.to_s)

    expecteds = [
      "S[S[K[S]][I]][K[I]][y]",
      "S[K[S]][I][y][K[I][y]]",
      "K[S][y][I[y]][K[I][y]]",
      "S[I[y]][K[I][y]]",
      "S[y][K[I][y]]",
      "S[y][I]",
    ]

    assert expression.reducible?
    while expression.reducible?
      expected = expecteds.shift
      assert_equal(expected, expression.to_s)
      expression = expression.reduce
    end
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

  def test_combinator
    expression = SKICall.new(SKICall.new(SKICall.new(S, @x), @y), @z)
    combinator = expression.combinator
    assert_equal("S", combinator.to_s)

    arguments = expression.arguments
    assert_equal([@x, @y, @z], arguments)

    assert_equal("x[z][y[z]]", combinator.call(*arguments).to_s)
  end

  def test_not_combinator
    # Leftest symbol is not combinator
    expression = SKICall.new(SKICall.new(@x, @y), @z)
    assert_equal("x[y][z]", expression.to_s)
    combinator = expression.combinator
    refute combinator.callable?

    arguments = expression.arguments
    assert_equal([@y, @z], arguments)

    assert_raises do
      combinator.call(*arguments)
    end
  end
end

class IOTATest < Minitest::Test
  def nested_iota(n)
    if n == 0
      return ""
    elsif n == 1
      return "ι"
    else
      return "ι[#{nested_iota(n - 1)}]"
    end
  end

  def test_s_to_iota
    actual = S.to_iota
    assert_equal(nested_iota(5), actual.to_s)

    while actual.reducible?
      actual = actual.reduce
    end
    assert_equal(S, actual)
  end

  def test_k_to_iota
    actual = K.to_iota
    assert_equal(nested_iota(4), actual.to_s)

    while actual.reducible?
      actual = actual.reduce
    end
    assert_equal(K, actual)
  end

  def test_i_to_iota
    actual = I.to_iota
    assert_equal(nested_iota(2), actual.to_s)

    while actual.reducible?
      actual = actual.reduce
    end
    # S[K][K[K]] act equaly "I"
    expected = SKICall.new(SKICall.new(S, K), SKICall.new(K, K))
    assert_equal(expected, actual)
  end
end
