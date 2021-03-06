require "set"
require_relative "./farule.rb"
require_relative "./dfa.rb"

class NFARulebook < Struct.new(:rules)
  def next_states(states, character)
    return states.flat_map { |state| follow_rules_for(state, character) }.to_set
  end

  def follow_rules_for(state, character)
    return rules_for(state, character).map(&:follow)
  end

  def rules_for(state, character)
    return rules.select { |rule| rule.applies_to?(state, character) }
  end

  def follow_free_moves(states)
    more_states = next_states(states, nil)
    if more_states.subset?(states)
      return states
    else
      return follow_free_moves(states + more_states)
    end
  end

  def alphabet
    return rules.map(&:character).compact.uniq
  end
end

class NFA < Struct.new(:current_states, :accept_states, :rulebook)
  def accepting?
    return (current_states & accept_states).any?
  end

  def read_character(character)
    self.current_states = rulebook.next_states(current_states, character)
  end

  def read_string(string)
    string.chars.each do |character|
      read_character(character)
    end
  end

  def current_states
    return rulebook.follow_free_moves(super)
  end
end

class NFADesign < Struct.new(:start_state, :accept_states, :rulebook)
  def accepts?(string)
    return to_nfa.tap { |nfa| nfa.read_string(string) }.accepting?
  end

  def to_nfa(current_states = Set[start_state])
    return NFA.new(current_states, accept_states, rulebook)
  end
end

class NFASimulation < Struct.new(:nfa_design)
  def next_state(state, character)
    return nfa_design.to_nfa(state).tap do |nfa|
             nfa.read_character(character)
           end.current_states
  end

  def rules_for(state)
    return nfa_design.rulebook.alphabet.map do |character|
             FARule.new(state, character, next_state(state, character))
           end
  end

  def discover_states_and_rules(states)
    rules = states.flat_map { |state| rules_for(state) }
    more_states = rules.map(&:follow).to_set
    if more_states.subset?(states)
      return [states, rules]
    else
      return discover_states_and_rules(states + more_states)
    end
  end

  def to_dfa_design
    start_state = nfa_design.to_nfa.current_states
    states, rules = discover_states_and_rules(Set[start_state])
    accept_states = states.select { |state| nfa_design.to_nfa(state).accepting? }
    return DFADesign.new(start_state, accept_states, DFARuleBook.new(rules))
  end
end
