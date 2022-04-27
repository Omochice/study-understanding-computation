require_relative "turing-machine.rb"

class DTMRulebook < Struct.new(:rules)
  def next_configuration(configuration)
    return rule_for(configuration).follow(configuration)
  end

  def rule_for(configuration)
    return self.rules.detect { |rule| rule.applies_to?(configuration) }
  end

  def applies_to?(configuration)
    return !rule_for(configuration).nil?
  end
end

class DTM < Struct.new(:current_configuration, :accept_states, :rulebook)
  def accepting?
    return self.accept_states.include?(self.current_configuration.state)
  end

  def step
    self.current_configuration = self.rulebook.next_configuration(self.current_configuration)
  end

  def run
    # step until accepting?
    until accepting? || stuck?
      step
    end
  end

  def stuck?
    return !accepting? && !self.rulebook.applies_to?(self.current_configuration)
  end
end
