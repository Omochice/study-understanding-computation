require_relative "./tag-system.rb"

class CyclicTagRule < TagRule
  FIRST_CHARACTER = "1"

  def initialize(append_characters)
    super(FIRST_CHARACTER, append_characters)
  end

  def inspect
    return "#<CyclicTagRule #{append_characters.inspect}"
  end
end

class CyclicTagRuleBook < Struct.new(:rules)
  DELETION_NUMBER = 1

  def initialize(rules)
    super(rules.cycle)
  end

  def applies_to?(string)
    return string.length >= DELETION_NUMBER
  end

  def next_string(string)
    return follow_next_rule(string).slice(DELETION_NUMBER..-1)
  end

  def follow_next_rule(string)
    rule = self.rules.next
    if rule.applies_to?(string)
      return rule.follow(string)
    else
      return string
    end
  end
end

class CyclicTagEncoder < Struct.new(:alphabet)
  def encode_string(string)
    return string.chars.map { |character| encode_character(character) }.join
  end

  def encode_character(character)
    character_position = alphabet.index(character)
    return (0...alphabet.length).map { |n| n == character_position ? "1" : "0" }.join
  end
end

# TODO: stop monkey patch
class TagRule
  def to_cyclic(encoder)
    return CyclicTagRule.new(encoder.encode_string(self.append_characters))
  end
end

class TagSystem
  def encoder
    return CyclicTagEncoder.new(self.alphabet)
  end
end
