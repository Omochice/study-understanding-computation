require "minitest/autorun"
require_relative "../../src/lambda/numbers.rb"
require_relative "../../src/lambda/operators.rb"
require_relative "../../src/lambda/statements.rb"
require_relative "./helper.rb"

class StatementsTest < Minitest::Test
  def test_if
    assert_equal("expected", IF[TRUE]["expected"]["not expected"])
    assert_equal("expected", IF[FALSE]["not expected"]["expected"])
  end

  def test_is_zero
    assert to_boolean(IS_ZERO[ZERO])
    refute to_boolean(IS_ZERO[ONE])
    refute to_boolean(IS_ZERO[TWO])
    refute to_boolean(IS_ZERO[THREE])
  end

  def test_is_less_or_equal
    refute to_boolean(IS_LESS_OR_EQUAL[TWO][ONE])
    assert to_boolean(IS_LESS_OR_EQUAL[TWO][TWO])
    assert to_boolean(IS_LESS_OR_EQUAL[TWO][THREE])
  end
end
