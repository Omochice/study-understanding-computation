require "minitest/autorun"
require_relative "../../src/universality/partial-recursive-function.rb"

class PertialRecursiveFunctionTest < Minitest::Test
  def test_zero
    assert_equal(0, zero())
  end

  def test_increment
    assert_equal(1, increment(zero()))
  end

  def test_new_function
    def two
      return increment(increment(zero))
    end

    assert_equal(2, two())

    def three
      increment(two())
    end

    assert_equal(3, three())

    def add_three(x)
      increment(increment(increment(x)))
    end

    assert_equal(5, add_three(two))
  end
end

class RecurseTest < Minitest::Test
  def setup
    @two = increment(increment(zero))
    @three = increment(@two)
  end

  # {{{
  # define operate that using 0
  def add_zero_to_x(x)
    return x
  end

  def increment_easier_result(x, easier_y, easier_result)
    return increment(easier_result)
  end

  def add(x, y)
    return recurse(:add_zero_to_x, :increment_easier_result, x, y)
  end

  def test_add
    assert_equal(0, add_zero_to_x(zero()))
    assert_equal(1, add_zero_to_x(increment(zero())))

    assert_equal(5, add(@two, @three))
  end

  # }}}

  # {{{
  def multiply_x_by_zero(x)
    return zero
  end

  def add_x_to_easier_result(x, easier_y, easier_result)
    return add(x, easier_result)
  end

  def multiply(x, y)
    return recurse(:multiply_x_by_zero, :add_x_to_easier_result, x, y)
  end

  def test_multiply
    # define operate that using 0
    assert_equal(0, multiply_x_by_zero(@two))
    assert_equal(0, multiply_x_by_zero(@three))

    assert_equal(6, multiply(@two, @three))
  end

  # }}}

  # {{{
  def easier_x(easier_x, easier_result)
    return easier_x
  end

  def decrement(x)
    return recurse(:zero, :easier_x, x)
  end

  def substract_zero_from_x(x)
    return x
  end

  def decrement_easier_result(x, easier_y, easier_result)
    return decrement(easier_result)
  end

  def substract(x, y)
    return recurse(:substract_zero_from_x, :decrement_easier_result, x, y)
  end

  def test_decrement
    assert_equal(2, decrement(@three))
    assert_equal(1, decrement(@two))
    ## negative values are not exist this world
    # assert_equal(-1, decrement(zero()))
    assert_equal(0, decrement(zero()))
  end

  def test_substract
    assert_equal(1, substract(@three, @two))
    assert_equal(0, substract(@two, @two))
    assert_equal(0, substract(@two, @three))
  end

  # }}}

  # {{{
  def divide(x, y)
    return minimize {
             |n|
             substract(increment(x), multiply(y, increment(n)))
           }
  end

  def test_divide
    six = multiply(@two, @three)
    ten = increment(multiply(@three, @three))
    assert_equal(3, divide(six, @two))
    assert_equal(3, divide(ten, @three))
  end

  # }}}
end
