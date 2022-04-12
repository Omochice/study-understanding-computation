require "minitest/autorun"
require_relative "../src/classes.rb"

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
    end
  end
end
