require "minitest/autorun"
require "treetop"
require_relative "../../src/lambda/syntax.rb"

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
    assert_equal(pattern, ast.to_s)
    assert_equal("S[S[K[S]][S[K[K]][I]]][S[S[K[S]][S[K[K]][I]]][K[I]]]",
                 ast.to_ski.to_s)
  end
end

