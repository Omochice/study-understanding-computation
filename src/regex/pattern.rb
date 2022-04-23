require_relative "../finite-automaton/nfa.rb"
require_relative "../finite-automaton/farule.rb"

module Pattern
  def bracket(outer_precedence)
    if precedence < outer_precedence
      return "(" + to_s + ")"
    else
      return to_s
    end
  end

  def inspect
    return "/#{self}/"
  end

  def matches?(string)
    return to_nfa_design.accepts?(string)
  end
end

class Empty
  include Pattern

  def to_s
    return ""
  end

  def precedence
    return 3
  end

  def to_nfa_design
    start_state = Object.new
    accept_states = [start_state]
    rulebook = NFARulebook.new([])
    return NFADesign.new(start_state, accept_states, rulebook)
  end
end

class Literal < Struct.new(:character)
  include Pattern

  def to_s
    return character
  end

  def precedence
    return 3
  end

  def to_nfa_design
    start_state = Object.new
    accept_state = Object.new
    rule = FARule.new(start_state, character, accept_state)
    rulebook = NFARulebook.new([rule])
    return NFADesign.new(start_state, [accept_state], rulebook)
  end
end

class Concatenate < Struct.new(:first, :second)
  include Pattern

  def to_s
    return [first, second].map { |pattern| pattern.bracket(precedence) }.join
  end

  def precedence
    return 1
  end

  def to_nfa_design
    first_nfa_design = first.to_nfa_design
    second_nfa_design = second.to_nfa_design

    start_state = first_nfa_design.start_state
    accept_states = second_nfa_design.accept_states
    rules = first_nfa_design.rulebook.rules + second_nfa_design.rulebook.rules
    extra_rules = first_nfa_design.accept_states.map do |state|
      FARule.new(state, nil, second_nfa_design.start_state)
    end
    rulebook = NFARulebook.new(rules + extra_rules)

    return NFADesign.new(start_state, accept_states, rulebook)
  end
end

class Choose < Struct.new(:first, :second)
  include Pattern

  def to_s
    return [first, second].map { |pattern| pattern.bracket(precedence) }.join("|")
  end

  def precedence
    return 0
  end

  def to_nfa_design
    first_nfa_design = first.to_nfa_design
    second_nfa_design = second.to_nfa_design

    start_state = Object.new
    accept_states = first_nfa_design.accept_states + second_nfa_design.accept_states
    rules = first_nfa_design.rulebook.rules + second_nfa_design.rulebook.rules
    extra_rules = [first_nfa_design, second_nfa_design].map do |nfa_design|
      FARule.new(start_state, nil, nfa_design.start_state)
    end
    rulebook = NFARulebook.new(rules + extra_rules)

    return NFADesign.new(start_state, accept_states, rulebook)
  end
end

class Repeat < Struct.new(:pattern)
  include Pattern

  def to_s
    return pattern.bracket(precedence) + "*"
  end

  def precedence
    return 2
  end

  def to_nfa_design
    pattern_nfa_design = pattern.to_nfa_design
    start_state = Object.new
    accept_states = pattern_nfa_design.accept_states + [start_state]
    rules = pattern_nfa_design.rulebook.rules
    extra_rules = pattern_nfa_design.accept_states.map do |accept_state|
      FARule.new(accept_state, nil, pattern_nfa_design.start_state)
    end + [FARule.new(start_state, nil, pattern_nfa_design.start_state)]
    rulebook = NFARulebook.new(rules + extra_rules)

    return NFADesign.new(start_state, accept_states, rulebook)
  end
end
