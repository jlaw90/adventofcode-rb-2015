puts "Please enter the input:"

input = gets.chomp

puts "Crunching..."

def look_and_say(input, iterations)
  prev = input
  iterations.times do
    prev = prev.chars.chunk{|c| c}.map{|e,a| "#{a.length}#{e}"}.join
  end

  prev
end

## Problem 1 (40 iterations)
p1a = look_and_say(input, 40)
puts "Problem 1 result: #{p1a.length}"

## Problem 2 (50 iterations)
p2a = look_and_say(p1a, 10)
puts "Problem 2 result: #{p2a.length}"