require_relative "./analyzer.rb"

p LexicalAnalyzer.new("y = x * 7").analyze
p LexicalAnalyzer.new("while (x < 5) {x = x*3}").analyze
p LexicalAnalyzer.new("if (x < 10) { y =true; x=0} else { do-nothing }").analyze
