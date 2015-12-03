class Grid
  attr_reader :houses

  def initialize
    @houses = []
  end

  def visit(x, y)
    col = @houses.fetch(y, []) || []
    house = col.fetch(x, 0) || 0
    house += 1
    col[x] = house
    @houses[y] = col
  end
end

puts "Enter the directions and press return: "

## Problem 1...
grid = Grid.new
dirs = gets.chomp
x,y = 9999,9999
grid.visit(x, y)
dirs.chars.each do |d|
  case d
    when '^'
      y -= 1
    when 'v'
      y += 1
    when '>'
      x += 1
    when '<'
      x -= 1
  end
  grid.visit(x, y)
end

# How many houses receive at least one present?
puts "Number of houses visited: #{grid.houses.inject(0){|s, r| s + (r.nil?? 0: r.select{|i| !i.nil?}.length)}}"


## Problem 2 (could DRY this up but not worth it for this...)
grid = Grid.new

x,y = [9999,9999], [9999, 9999]

grid.visit(x[0], y[0])
grid.visit(x[1],y[1])

dirs.chars.each_with_index do |d,i|
  idx = i % 2
  case d
    when '^'
      y[idx] -= 1
    when 'v'
      y[idx] += 1
    when '>'
      x[idx] += 1
    when '<'
      x[idx] -= 1
  end
  grid.visit(x[idx], y[idx])
end

# How many houses receive at least one present?
puts "Number of houses visited: #{grid.houses.inject(0){|s, r| s + (r.nil?? 0: r.select{|i| !i.nil?}.length)}}"