puts "Please enter the json document and press return..."

json = gets.chomp

# Problem 1
p1a = json.scan(/\-?\d+/).map{|a| a.to_i}.inject(0, :+)

puts "Problem 1 answer: #{p1a}"

# Problem 2
str = json
loop do
  idx = str.index(':"red"')
  break unless idx
  substart = str.rindex('{', idx)
  count = 0
  i = substart
  loop do
    char = str[i]
    count += 1 if char == '{'
    count -= 1 if char == '}'
    break if count == 0
    i += 1
  end

  str = str[0,substart] +'"<stripped>"' + str[(i+1)..-1]
end

p1a = str.scan(/\-?\d+/).map{|a| a.to_i}.inject(0, :+)

puts "Problem 2 answer: #{p1a}"