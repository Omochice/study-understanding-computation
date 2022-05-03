require "minitest/autorun"
require "treetop"
require_relative "../../src/lambda/syntax.rb"

class ParserTest < Minitest::Test
  def setup
    filename = File.join(
      File.dirname(File.dirname(File.dirname(__FILE__))),
      "src",
      "lambda",
      "parser.treetop",
    )
    Treetop.load(filename)
  end

  def test_parse
    pattern = "-> x { x[x] }[-> y { y }]"
    parser = LambdaCalculusParser.new
    parse_tree = parser.parse(pattern)
    expression = parse_tree.to_ast
    assert_equal(pattern, expression.to_s)
    assert_equal("-> y { y }[-> y { y }]", expression.reduce.to_s)
  end
end
