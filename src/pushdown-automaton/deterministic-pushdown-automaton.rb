class DPDARulebook < Struct.new(:rules)
  def next_configuration(configuration, character)
    return rule_for(configuration, character).follow(configuration)
  end

  def rule_for(configuration, character)
    return rules.detect { |rule| rule.applies_to?(configuration, character) }
  end
end
