require "minitest/autorun"
require "treetop"
require_relative "../../src/lambda/syntax.rb"
require_relative "../../src/universality/ski-combinator.rb"

class LambdaCalculusToSKiTest < Minitest::Test
  def setup
    filename = File.join(
      File.dirname(File.dirname(File.dirname(__FILE__))),
      "src",
      "lambda",
      "parser.treetop",
    )
    Treetop.load(filename)
  end

  def test_to_ski
    pattern = "-> p { -> x { p[p[x]] } }"
    parser = LambdaCalculusParser.new
    ast = parser.parse(pattern).to_ast
    two = ast.to_ski
    expected = "S[S[K[S]][S[K[K]][I]]][S[S[K[S]][S[K[K]][I]]][K[I]]]"
    assert_equal(pattern, ast.to_s)
    assert_equal(expected, two.to_s)

    inc = SKISymbol.new(:inc)
    zero = SKISymbol.new(:zero)
    expression = SKICall.new(SKICall.new(two, inc), zero)
    assert_equal(expected + "[inc][zero]", expression.to_s)
    assert expression.reducible?
    # too long to write all step
    # maybe it ok if accept last case
    while expression.reducible?
      expression = expression.reduce
    end
    assert_equal("inc[inc[zero]]", expression.to_s)
  end
end
