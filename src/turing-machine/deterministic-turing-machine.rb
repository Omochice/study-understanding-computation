require_relative "turing-machine.rb"

class DTMRulebook < Struct.new(:rules)
  def next_configuration(configuration)
    return rule_for(configuration).follow(configuration)
  end

  def rule_for(configuration)
    return self.rules.detect { |rule| rule.applies_to?(configuration) }
  end
end
