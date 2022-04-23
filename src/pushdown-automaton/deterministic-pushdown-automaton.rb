require_relative "./stack.rb"
require_relative "./pushdown-automaton-rule.rb"

class DPDARulebook < Struct.new(:rules)
  def next_configuration(configuration, character)
    return rule_for(configuration, character).follow(configuration)
  end

  def rule_for(configuration, character)
    return rules.detect { |rule| rule.applies_to?(configuration, character) }
  end

  def applies_to?(configuration, character)
    return !rule_for(configuration, character).nil?
  end

  def follow_free_moves(configuration)
    if applies_to?(configuration, nil)
      return follow_free_moves(next_configuration(configuration, nil))
    else
      return configuration
    end
  end
end

class DPDA < Struct.new(:current_configuration, :accept_states, :rulebook)
  def accepting?
    return accept_states.include?(current_configuration.state)
  end

  def read_character(character)
    self.current_configuration = rulebook.next_configuration(current_configuration, character)
  end

  def read_string(string)
    string.chars.each do |character|
      read_character(character)
    end
  end

  def current_configuration
    return rulebook.follow_free_moves(super)
  end
end

class DPDADesign < Struct.new(:start_state, :bottom_character,
                              :accept_states, :rulebook)
  def accepts?(string)
    to_dpda.tap { |dpda| dpda.read_string(string) }.accepting?
  end

  def to_dpda
    start_stack = Stack.new([bottom_character])
    start_configuration = PDAConfiguration.new(start_state, start_stack)
    return DPDA.new(start_configuration, accept_states, rulebook)
  end
end
