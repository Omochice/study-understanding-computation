class DPDARulebook < Struct.new(:rules)
  def next_configuration(configuration, character)
    return rule_for(configuration, character).follow(configuration)
  end

  def rule_for(configuration, character)
    return rules.detect { |rule| rule.applies_to?(configuration, character) }
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
end
