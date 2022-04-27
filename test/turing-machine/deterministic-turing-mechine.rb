require "minitest/autorun"
require_relative "../../src/turing-machine/tape.rb"
require_relative "../../src/turing-machine/turing-machine.rb"
require_relative "../../src/turing-machine/deterministic-turing-machine.rb"

class DTMRulebookTest < Minitest::Test
  def setup
    @tape = Tape.new(["1", "0", "1"], "1", [], "_")
    @rulebook = DTMRulebook.new([
      TMRule.new(1, "0", 2, "1", :right),
      TMRule.new(1, "1", 1, "0", :left),
      TMRule.new(1, "_", 2, "1", :right),
      TMRule.new(2, "0", 2, "0", :right),
      TMRule.new(2, "1", 2, "1", :right),
      TMRule.new(2, "_", 3, "_", :left),
    ])
  end

  def test_next_configuration
    configuration = TMConfiguration.new(1, @tape)
    configuration = @rulebook.next_configuration(configuration)
    expected = TMConfiguration.new(1, Tape.new(["1", "0"], "1", ["0"], "_"))
    assert_equal(configuration, expected)

    configuration = @rulebook.next_configuration(configuration)
    expected = TMConfiguration.new(1, Tape.new(["1"], "0", ["0", "0"], "_"))
    assert_equal(configuration, expected)

    configuration = @rulebook.next_configuration(configuration)
    expected = TMConfiguration.new(2, Tape.new(["1", "1"], "0", ["0"], "_"))
    assert_equal(configuration, expected)
  end
end

class DTMTest < Minitest::Test
  def setup
    tape = Tape.new(["1", "0", "1"], "1", [], "_")
    rulebook = DTMRulebook.new([
      TMRule.new(1, "0", 2, "1", :right),
      TMRule.new(1, "1", 1, "0", :left),
      TMRule.new(1, "_", 2, "1", :right),
      TMRule.new(2, "0", 2, "0", :right),
      TMRule.new(2, "1", 2, "1", :right),
      TMRule.new(2, "_", 3, "_", :left),
    ])
    @dtm = DTM.new(TMConfiguration.new(1, tape), [3], rulebook)
  end

  def test_step
    refute @dtm.accepting?
    @dtm.step # 1010
    refute @dtm.accepting?
    @dtm.step # 1000
    refute @dtm.accepting?
    @dtm.step # 1100
    refute @dtm.accepting?
    @dtm.step # 1100
    refute @dtm.accepting?
    @dtm.step # 1100
    refute @dtm.accepting?
    @dtm.step # nil
    assert @dtm.accepting?
  end

  def test_run
    refute @dtm.accepting?
    @dtm.run
    assert @dtm.accepting?
  end
end
