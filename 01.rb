puts "Please paste your pattern into the console and press enter."
pattern = gets.chomp

# Problem 1
puts "Day 1#1: " + pattern.chars.inject(0){|f, c| f + (c == ?(? 1: -1)}.to_s


# Problem 2
floor, idx = 0, -1
pattern.chars.each_with_index do |c, i|
  floor += c == ?(? 1: -1

  if floor == -1
    idx = i + 1
    break
  end
end
puts "Day 1#2: #{idx}"