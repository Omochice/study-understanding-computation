require_relative "./pattern.rb"

nfa_design = Empty.new.to_nfa_design
p nfa_design.accepts?("")
p nfa_design.accepts?("a")

nfa_design = Literal.new("a").to_nfa_design
p nfa_design.accepts?("")
p nfa_design.accepts?("a")
p nfa_design.accepts?("b")
