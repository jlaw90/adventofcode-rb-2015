class LightGrid
  attr_accessor :width, :height, :lights

  def initialize(width=1000, height=1000, default = false)
    @width = width
    @height = height
    @lights = Array.new(width*height, default)
  end

  def map!(start_x, start_y, end_x, end_y, &block)
    start_x, end_x = *[start_x, end_x].sort
    start_y, end_y = *[start_y, end_y].sort

    off = start_y * width + start_x
    dif = end_x - start_x
    scan = width - dif - 1
    start_y.upto(end_y).each do |y|
      start_x.upto(end_x).each do |x|
        #off = y * width + x # Optimised out
        @lights[off] = block.call(@lights[off])
        off += 1
      end

      off += scan
    end
  end

  def light(x, y)
    @lights[y * width + x]
  end
end

puts "Please enter the commands line by line with an empty line at the end"

commands = []

while (str = gets.chomp) != ''
  commands << str
end

## Problem 1 - how many lights are lit after following instructions?
grid = LightGrid.new(1000, 1000, false)

commands.each do |cmd|
  unless /(?<start_x>\d+),(?<start_y>\d+) through (?<end_x>\d+),(?<end_y>\d+)$/ =~ cmd
    puts "Regex failed to get coords for: #{cmd}!!"
  end
  coords = [start_x, start_y, end_x, end_y].map(&:to_i)


  case cmd
    when /^turn on/
      grid.map!(*coords) { |v| true }
    when /^turn off/
      grid.map!(*coords) { |v| false }
    when /^toggle/
      grid.map!(*coords) { |v| !v }
    else
      puts "Unknown command: #{cmd}"
  end
end

puts "Problem 1: #{grid.lights.count{|l| l}} lights are turned on"

## Problem 2 - grid semantics change...
grid = LightGrid.new(1000, 1000, 0)
commands.each do |cmd|
  unless /(?<start_x>\d+),(?<start_y>\d+) through (?<end_x>\d+),(?<end_y>\d+)$/ =~ cmd
    puts "Regex failed to get coords for: #{cmd}!!"
  end
  coords = [start_x, start_y, end_x, end_y].map(&:to_i)


  case cmd
    when /^turn on/
      grid.map!(*coords) { |v| v + 1 }
    when /^turn off/
      grid.map!(*coords) { |v| [0, v - 1].max }
    when /^toggle/
      grid.map!(*coords) { |v| v + 2 }
    else
      puts "Unknown command: #{cmd}"
  end
end

puts "Problem 2: #{grid.lights.reduce(0){|s,l| s + l}} total brightness!"