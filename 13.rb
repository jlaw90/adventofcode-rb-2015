puts "Please enter the seating arrangement happiness calculations..."

lines = []
while (str = gets.chomp) != ''
  lines << str
end

class Person
  attr_reader :name, :edges

  def initialize(name)
    @name = name
    @edges = {} # Map from this node to other nodes...
  end
end

class Edge
  attr_reader :from, :to, :happiness

  def initialize(from, to, happiness)
    @from, @to, @happiness = from, to, happiness
  end
end


## Build models...
name_map = {}
people = []
lines.each do |line|
  raise "Confusing input: #{line}" unless /^(?<from>[A-Za-z]+) would (?<sign>gain|lose) (?<happiness>\d+) happiness units by sitting next to (?<to>[A-Za-z]+)\.$/ =~ line

  people << name_map[from] = Person.new(from) unless name_map.has_key?(from)
  people << name_map[to] = Person.new(to) unless name_map.has_key?(to)
  from, to = name_map[from], name_map[to]

  from.edges[to] = Edge.new(from, to, happiness.to_i * (sign == 'gain' ? 1 : -1))
end

def happy_map(node_list)
  arr = []
  node_list.permutation do |perm|
    first, last = perm[0], perm[perm.length - 1]
    happiness = first.edges[last].happiness + last.edges[first].happiness
    happiness = (1..(perm.length-1)).to_a.inject(happiness) do |sum, index|
      sum + perm[index].edges[perm[index-1]].happiness + perm[index-1].edges[perm[index]].happiness
    end
    arr << {happiness: happiness, arrangement: perm}
  end
  arr
end

## Problem 1: total change in happiness for the optimal seating arrangement
p1a = happy_map(people).sort { |a, b| a[:happiness] <=> b[:happiness] }.last[:happiness]
puts "Problem 1 answer: #{p1a}"

## Problem 2: add yourself as a neutral party, same calculations...
me = Person.new('Me')
people.each do |p|
  p.edges[me] = Edge.new(p, me, 0)
  me.edges[p] = Edge.new(me, p, 0)
end
people << me
p2a = happy_map(people).sort { |a, b| a[:happiness] <=> b[:happiness] }.last[:happiness]
puts "Problem 1 answer: #{p2a}"