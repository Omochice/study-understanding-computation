require "minitest/autorun"
require_relative "../../src/lambda/boolean.rb"
require_relative "./helper.rb"

class BooleanTest < Minitest::Test
  def test_true
    assert to_boolean(TRUE)
  end

  def test_false
    refute to_boolean(FALSE)
  end
end
