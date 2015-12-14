puts "Please enter reindeer stats!"

lines = []
while (str = gets.chomp) != ''
  lines << str
end

class Reindeer
  attr_reader :name, :speed, :limit, :rest_time

  def initialize(name, speed, limit, rest_time)
    @name, @speed, @limit, @rest_time = name, speed, limit, rest_time
  end

  def position_at(secs)
    stride = self.limit + self.rest_time #
    strides = (secs / stride).floor
    secs -= stride * strides
    pos = self.speed * self.limit * strides

    # Partial
    sprint = [secs, limit].min
    pos += sprint * self.speed

    pos
  end
end

# Build models...
reindeer = []

lines.each do |line|
  raise "Invalid input: #{line}" unless /^(?<name>\w+) can fly (?<speed>\d+) km\/s for (?<limit>\d+) seconds, but then must rest for (?<rest_time>\d+) seconds\.$/ =~ line

  reindeer << Reindeer.new(name, speed.to_i, limit.to_i, rest_time.to_i)
end

## Problem 1
puts "Please enter which second of the race you would like the winning statistics for"
sec = gets.chomp.to_i
winner = reindeer.map{|r| {reindeer: r.name, distance: r.position_at(sec)}}.sort{|a,b| a[:distance] <=> b[:distance]}.last

puts "Problem 1 answer: #{winner[:distance]} km travelled by #{winner[:reindeer]}"

## Problem 2 - scoring based system
points = Hash[reindeer.map{|r| [r.name, 0]}]

sec.times do |sec|
  lead = reindeer.map{|r| {reindeer: r.name, distance: r.position_at(sec)}}.sort{|a,b| a[:distance] <=> b[:distance]}.last
  points[lead[:reindeer]] += 1
end

winner = points.map{|k,v| {reindeer: k, points: v}}.sort{|a,b| a[:points] <=> b[:points]}.last
puts "Problem 2 answer: #{winner[:points]} points scored by #{winner[:reindeer]}"