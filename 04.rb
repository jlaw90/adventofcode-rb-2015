require 'digest'

puts 'Please enter your secret key:'
secretz = gets.chomp

# Problem 1, find a hash "#{secretz}#{i}" with the lowest 'i' as a positive integer that has at least 5 leading 0's in hexadecimal
def find_hash_with_zero_length_of(secret, num, start = 1)
  md5, i = Digest::MD5.new, start
  search = '0' * num
  loop do
    hash = md5.hexdigest "#{secret}#{i}"

    break if hash[0...num] == search

    i += 1
  end

  i
end

p1 = find_hash_with_zero_length_of(secretz, 5)
puts "Problem 1: #{p1}"

puts "Problem 2: #{find_hash_with_zero_length_of(secretz, 6, p1)}" # Can start from where p1 got to...