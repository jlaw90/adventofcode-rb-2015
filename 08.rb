class CodeString # Urgh
  attr_accessor :string

  def initialize(str)
    @string = str
  end


  def parsed
    @string[1..-2].gsub('\\"', '"').gsub(/\\x([0-9A-Fa-f]{2})/) {$1.hex.chr}.gsub('\\\\', '\\')
  end

  def encoded
    '"' + @string.gsub('\\', '\\\\\\').gsub('"', '\\"') + '"'
  end
end


puts 'Please enter the input:'

input = []
while (str = gets.chomp) != ''
  input << CodeString.new(str)
end

## Problem 1
p1a = input.inject(0){|s,i| s + i.string.chars.length} - input.inject(0){|s,i| s + i.parsed.chars.length}
puts "Problem 1 answer: #{p1a}"

## Problem 2
p2a = input.inject(0){|s, i| s + i.encoded.chars.length} - input.inject(0){|s,i| s + i.string.chars.length}
puts "Problem 2 answer: #{p2a}"