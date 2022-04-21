require "minitest/autorun"
require_relative "../../src/classes.rb"

class NumberTest < Minitest::Test
  def test_to_s
    100.times do
      n = rand(0..1000)
      num = Number.new(n)
      assert_equal(num.to_s, "#{n}")
    end
  end

  def test_inspect
    100.times do
      n = rand(0..1000)
      num = Number.new(n)
      assert_equal("<<#{n}>>", num.inspect)
    end
  end
end

class AddTest < Minitest::Test
  def test_to_s
    100.times do
      l = rand(0..1000)
      r = rand(0..1000)
      left = Number.new(l)
      right = Number.new(r)
      actual = Add.new(left, right).to_s
      assert_equal("#{l} + #{r}", actual)
    end
  end

  def test_inspect
    100.times do
      l = rand(0..1000)
      r = rand(0..1000)
      left = Number.new(l)
      right = Number.new(r)
      actual = Add.new(left, right).inspect
      assert_equal("<<#{l} + #{r}>>", actual)
    end
  end

  def test_reducible
    100.times do
      l = rand(0..1000)
      r = rand(0..1000)
      left = Number.new(l)
      right = Number.new(r)
      actual = Add.new(left, right).reducible?
      assert(actual)
    end
  end

  def test_reduce
    100.times do
      l = rand(0..1000)
      r = rand(0..1000)
      left = Number.new(l)
      right = Number.new(r)
      actual = Add.new(left, right).reduce
      assert_instance_of(Number, actual)
      assert_equal(Number.new(l + r), actual)
      refute(actual.reducible?)
    end
  end
end

class MultiplyTest < Minitest::Test
  def test_to_s
    100.times do
      l = rand(0..1000)
      r = rand(0..1000)
      left = Number.new(l)
      right = Number.new(r)
      actual = Multiply.new(left, right).to_s
      assert_equal("#{l} * #{r}", actual)
    end
  end

  def test_inspect
    100.times do
      l = rand(0..1000)
      r = rand(0..1000)
      left = Number.new(l)
      right = Number.new(r)
      actual = Multiply.new(left, right).inspect
      assert_equal("<<#{l} * #{r}>>", actual)
    end
  end

  def test_reducible
    100.times do
      l = rand(0..1000)
      r = rand(0..1000)
      left = Number.new(l)
      right = Number.new(r)
      actual = Multiply.new(left, right).reducible?
      assert(actual)
    end
  end

  def test_reduce
    100.times do
      l = rand(0..1000)
      r = rand(0..1000)
      left = Number.new(l)
      right = Number.new(r)
      actual = Multiply.new(left, right).reduce
      assert_instance_of(Number, actual)
      assert_equal(Number.new(l * r), actual)
      refute(actual.reducible?)
    end
  end
end

class BooleanTest < Minitest::Test
  def test_to_s
    t = Boolean.new(true)
    f = Boolean.new(false)
    assert_equal("true", t.to_s)
    assert_equal("false", f.to_s)
  end

  def test_inspect
    t = Boolean.new(true)
    f = Boolean.new(false)
    assert_equal("<<true>>", t.inspect)
    assert_equal("<<false>>", f.inspect)
  end

  def test_reducible
    t = Boolean.new(true)
    f = Boolean.new(false)
    [t, f].each do |v|
      refute(v.reducible?)
    end
  end
end

class LessThanTest < Minitest::Test
  def test_to_s
    100.times do
      l = rand(0..1000)
      r = rand(0..1000)
      actual = LessThan.new(Number.new(l), Number.new(r)).to_s
      assert_equal("#{l} < #{r}", actual)
    end
  end

  def test_inspect
    100.times do
      l = rand(0..1000)
      r = rand(0..1000)
      actual = LessThan.new(Number.new(l), Number.new(r)).inspect
      assert_equal("<<#{l} < #{r}>>", actual)
    end
  end

  def test_reducible
    100.times do
      l = rand(0..1000)
      r = rand(0..1000)
      actual = LessThan.new(Number.new(l), Number.new(r)).reducible?
      assert(actual)
    end
  end

  def test_reduce
    100.times do
      l = rand(0..1000)
      r = rand(0..1000)
      actual = LessThan.new(Number.new(l), Number.new(r)).reduce
      assert_instance_of(Boolean, actual)
      assert_equal(Boolean.new(l < r), actual)
      refute(actual.reducible?)
    end
  end
end

class VariableTest < Minitest::Test
  def test_to_s
    v = Variable.new(:x)
    assert_equal("x", v.to_s)
  end

  def test_inspect
    v = Variable.new(:x)
    assert_equal("<<x>>", v.inspect)
  end

  def test_reducible
    v = Variable.new(:x)
    assert(v.reducible?)
  end

  def test_reduce
    100.times do
      v = Variable.new(:x)
      expected = Number.new(rand(0..1000))
      env = { x: expected }
      actual = v.reduce(env)
      assert_instance_of(expected.class, actual)
      assert_equal(expected, actual)
    end
  end
end
