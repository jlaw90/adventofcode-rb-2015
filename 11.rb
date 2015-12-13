puts 'Please enter Santa\'s password'
password = gets.chomp

# 8 lowercase letters, one straight run of 3 letters, cannot contain i, o or l, two double letters...

def find_match(start, &block)
  str = start
  until block.call(str)
    str = str.succ
  end
  str
end

# Lookups...
ab = ('a'..'z').to_a
doubles = ab.map{|c| c*2}
straights = ab[0..-3].map{|c| "#{c}#{c.succ}#{c.succ.succ}"}

# Problem 1
check = Proc.new{|str| straights.any?{|s| str.include?(s)} and doubles.count{|d| str.include?(d)} >= 2 and !%w(i o l).any?{|l| str.include?(l)}}
p1a = find_match(password, &check)
puts "Problem 1 answer: #{p1a}"

# Problem 2
p1a = find_match(p1a.succ, &check)
puts "Problem 2 answer: #{p1a}"