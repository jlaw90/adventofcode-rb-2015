puts "Please enter all route posibilities line by line and press return"
routes = []
while (str = gets.chomp) != ''
  routes << str
end

# Graph model...
class Edge
  attr_reader :distance, :from, :to

  def initialize(from, to, distance)
    @from, @to, @distance = from, to, distance
  end
end

class Node
  attr_reader :name
  attr_accessor :edges

  def initialize(name)
    @name = name
    @edges = []
  end

  def to(node)
    edges.find { |e| e.to == node }
  end
end

# Build the graph...
node_map = {}
nodes = []
routes.each do |route|
  raise "Invalid route input: #{route}" unless /^(?<place_a>\w+) to (?<place_b>\w+) = (?<distance>\d+)$/ =~ route

  nodes << node_map[place_a] = Node.new(place_a) unless node_map.has_key?(place_a)
  nodes << node_map[place_b] = Node.new(place_b) unless node_map.has_key?(place_b)
  node_a, node_b = node_map[place_a], node_map[place_b]
  node_a.edges << Edge.new(node_a, node_b, distance.to_i)
  node_b.edges << Edge.new(node_b, node_a, distance.to_i)
end

## Problem 1 - shortest distance....
def route_permutations(nodes, comparison_init, &comparator)
  comparison = comparison_init
  comparison_route = []
  nodes.permutation do |perm|
    distance = (1..(perm.length-1)).to_a.inject(0) { |s, i| s + perm[i-1].to(perm[i]).distance }

    if comparator.call(comparison, distance)
      comparison = distance
      comparison_route = perm
    end
  end
  [comparison, comparison_route]
end


shortest_dist, shortest_route = route_permutations(nodes, Float::INFINITY) { |shortest, dist| dist < shortest }

puts "Problem 1: shortest distance: #{shortest_dist} (#{shortest_route.map(&:name) * ' -> '})"

## Problem 2 - longest distance....
longest_dist, longest_route = route_permutations(nodes, 0) { |longest, dist| dist > longest }

puts "Problem 2: longest distance: #{longest_dist} (#{longest_route.map(&:name) * ' -> '})"