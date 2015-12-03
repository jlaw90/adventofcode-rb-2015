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

dirs = gets.chomp

# Large value is set to 9999 as we start there, this is horrible as it means we have to waste a lot of cycles when counting...
def houses_visited(directions, num_visitors, large_value=9999)
  # Directions are ordered, e.g. if 2 visitors, #0=#0, #1=#1, #2=#0, #3=#1, etc.

  grid = Grid.new
  x,y = [],[]

  num_visitors.times do |i|
    x[i], y[i] = large_value, large_value
    grid.visit(x[i], y[i])
  end

  directions.chars.each_with_index do |d,i|
    idx = i % num_visitors
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

  grid.houses.inject(0){|s, r| s + (r.nil?? 0: r.count{|i| !i.nil?})}
end

## Problem 1...

# How many houses receive at least one present?
puts "Number of houses visited: #{houses_visited(dirs, 1)}"


## Problem 2 (DRY'd...)

# How many houses receive at least one present?
puts "Number of houses visited: #{houses_visited(dirs, 2)}"