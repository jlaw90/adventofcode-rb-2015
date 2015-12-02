presents = []

# Read input
puts "Please enter each present dimension in the format LxWxH followed by a new line, after entering them all enter a blank line to start the computation"

loop do
  str = gets.chomp

  break if str.nil? or str.length == 0

  # Parse present
  presents.push(str.split('x').map(&:to_i))
end

## Problem 1
# Calculate total area of wrapping paper (2*l*w + 2*w*h + 2*h*l) + (smallest side)
sum = presents.inject(0) do |sum, p|
  lw = p[0] * p[1]
  wh = p[1] * p[2]
  hl = p[0] * p[2]

  sum + (2*lw + 2*wh + 2*hl) + [lw, wh, hl].min
end

puts "Total wrapping paper needed for all presents: #{sum} square feet!"

## Problem 2
# Calculate length of ribbon (shortest length around 4 sides + cubic size of package)
sum = presents.inject(0) do |sum, p|
  mins = p.dup.sort.take(2)
  sum + (mins[0] * 2) + (mins[1] * 2) + (p[0] * p[1] * p[2])
end

puts "Total length of ribbon required: #{sum} feet!"