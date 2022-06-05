class TagRule < Struct.new(:first_character, :append_characters)
  def applies_to?(string)
    return string.chars.first == self.first_character
  end

  def follow(string)
    return string + self.append_characters
  end
end

class TagRuleBook < Struct.new(:deletion_number, :rules)
  def next_string(string)
    return rule_for(string).follow(string).slice(self.deletion_number..-1)
  end

  def rule_for(string)
    return self.rules.detect { |r| r.applies_to?(string) }
  end

  def applies_to?(string)
    return !rule_for(string).nil? && string.length >= self.deletion_number
  end
end

class TagSystem < Struct.new(:current_string, :rulebook)
  def step
    self.current_string = self.rulebook.next_string(self.current_string)
  end

  def run
    while self.rulebook.applies_to?(current_string)
      yield current_string
      step
    end
    yield current_string
  end
end
