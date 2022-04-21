require "treetop"
require_relative "./pattern.rb"

filename = File.join(File.dirname(__FILE__), "regex.treetop")
Treetop.load(filename)

parse_tree = PatternParser.new.parse("(a(|b))*")
p parse_tree
p "----"

pattern = parse_tree.to_ast
p pattern

p pattern.matches?("abaab")
p pattern.matches?("abba")

