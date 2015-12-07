puts 'Please enter the input, with an empty line at the end'

input = []

while (str = gets.chomp) != ''
  input.push str
end


## Problem 1, number of nice strings
bad = %w(ab cd pq xy)
vowels = 'aeiou'.chars
doubles = 'abcdefghijklmnopqrstuvwxyz'.chars.map{|e| "#{e}#{e}"}
p1a = input.select do |inp|
  next false if bad.any?{|e| inp.include? e }
  next false unless inp.chars.select{|e| vowels.include? e }.length >= 3
  doubles.any? {|d| inp.include? d}
end

puts "Problem 1: #{p1a.length} 'nice' strings"


## Problem 2, new niceness specification (solution was not well planned but grew naturally - definitely not optimal)...
p2a = input.select do |inp|
  # - Contains a pair of any two letters that appear at least twice without overlapping

  # Calculate all two letter combinations that appear twice!
  combinations = (0..(inp.length - 2)).map{ |i| inp[i,2]}
  combinations = combinations.select{|c| combinations.select{|d| d == c}.length >= 2}.uniq
  next unless combinations.length > 0

  # Overlapping test
  nonoverlap = combinations.any? do |c|
    occurrences = []
    i = -1
    loop do
      i = inp.index(c, i + 1)
      break if i == nil
      occurrences << i
    end

    occurrences.any?{|i| occurrences.select{|j| j >= i + 2}.length >= 1}
  end

  next unless nonoverlap

  # - Contains at least one letter which repeats with exactly one letter between them
  next unless 0.upto(inp.length-2).to_a.select { |i| inp[i+2] == inp[i] }.length > 0

  true
end

puts "Problem 2: #{p2a.length} 'nice' strings"