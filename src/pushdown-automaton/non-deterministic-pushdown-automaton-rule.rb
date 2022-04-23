require "set"

class NPDARulebook < Struct.new(:rules)
  def next_configurations(configurations, character)
    return configurations.flat_map { |config| follow_rules_for(config, character) }.to_set
  end

  def follow_rules_for(configurations, character)
    return rules_for(configurations, character).map { |rule| rule.follow(configurations) }
  end

  def rules_for(configuration, character)
    return rules.select { |rule| rule.applies_to?(configuration, character) }
  end

  def follow_free_moves(configurations)
    more_configurations = next_configurations(configurations, nil)
    if more_configurations.subset?(configurations)
      return configurations
    else
      return follow_free_moves(configurations + more_configurations)
    end
  end
end

class NPDA < Struct.new(:current_configurations, :accept_states, :rulebook)
  def accepting?
    return current_configurations.any? do |config|
             accept_states.include?(config.state)
           end
  end

  def read_character(character)
    self.current_configurations = rulebook.next_configurations(current_configurations, character)
  end

  def read_string(string)
    string.chars.each do |character|
      read_character(character)
    end
  end

  def current_configurations
    return rulebook.follow_free_moves(super)
  end
end
