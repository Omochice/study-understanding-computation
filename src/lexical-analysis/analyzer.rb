class LexicalAnalyzer < Struct.new(:string)
  GRAMMAR = [
    { token: "i", pattern: /if/ },
    { token: "e", pattern: /else/ },
    { token: "w", pattern: /while/ },
    { token: "d", pattern: /do-nothing/ },
    { token: "(", pattern: /\(/ },
    { token: ")", pattern: /\)/ },
    { token: "{", pattern: /\{/ },
    { token: "}", pattern: /\}/ },
    { token: ";", pattern: /;/ },
    { token: "=", pattern: /=/ },
    { token: "+", pattern: /\+/ },
    { token: "*", pattern: /\*/ },
    { token: "<", pattern: /</ },
    { token: "n", pattern: /[0-9]+/ },
    { token: "b", pattern: /true|false/ },
    { token: "v", pattern: /[a-z]+/ },
  ]

  def analyze
    [].tap do |tokens|
      while more_tokens?
        tokens.push(next_token)
      end
    end
  end

  def more_tokens?
    return !self.string.empty?
  end

  def next_token
    rule, match = rule_matching(self.string)
    self.string = string_after(match)
    return rule[:token]
  end

  def rule_matching(string)
    mathces = GRAMMAR.map { |rule| match_at_beginning(rule[:pattern], string) }
    rules_with_matches = GRAMMAR.zip(mathces).reject { |rule, match| match.nil? }
    return rule_with_longest_match(rules_with_matches)
  end

  def match_at_beginning(pattern, string)
    return /\A#{pattern}/.match(string)
  end

  def rule_with_longest_match(rules_with_matches)
    return rules_with_matches.max_by { |rule, match| match.to_s.length }
  end

  def string_after(match)
    return match.post_match.lstrip
  end
end
