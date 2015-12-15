puts "Please enter ingredient stats!"

ingredient_map = {}
ingredients = []
while (str = gets.chomp) != ''
  raise "Invalid ingredient definition: #{str}" unless /^(?<name>\w+): (?<properties>(\w+ -?\d+(,\s+)?)+)$/ =~ str
  prop_map = Hash[properties.split(', ').map { |p| p.split(' ').each_with_index.map{|a,i| a.send(%w(to_sym to_i)[i])} }]
  ingredient_map[name] = prop_map.merge(name: name)
  ingredients << ingredient_map[name]
end

## Problem 1 - highest scoring cookie...

combos = ingredients.each_index.to_a.repeated_combination(100)
count_keys = ingredients[0].keys.reject{|k| %i(calories name).include? k}
scores = combos.map do |combo|
  recipe = Hash[combo.uniq.map{|j| [ingredients[j], combo.count(j)]}]

  prop_scores = count_keys.map do |k|
    v = recipe.inject(0) { |sum, (i, qty)| sum + i[k] * qty }
    v < 0? 0: v
  end

  [prop_scores.inject(:*), recipe]
end

scores.sort!{|a,b| a[0] <=> b[0]}

puts "Problem 1 answer: #{scores.last[0]} (#{scores.last[1].map{|(i,qty)| "#{qty} #{i[:name]}"} * ', '})"

## Problem 2 - highest scoring with exactly 500 calories...
scores.select!{|(score, recipe)| recipe.inject(0){|sum, (i, qty)| sum + i[:calories] * qty} == 500}

puts "Problem 2 answer: #{scores.last[0]} (#{scores.last[1].map{|(i,qty)| "#{qty} #{i[:name]}"} * ', '})"