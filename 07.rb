puts "Please enter the circuit definition line by line with a blank line at the end"

lines = []
while (str = gets.chomp) != ''
  lines << str
end

class Operation
  def initialize(context, op, lhs, rhs, dest)
    @context, @op, @lhs, @rhs, @dest = context, op, lhs, rhs, dest
  end

  def rshift(l, r)
    l >> r
  end

  def lshift(l, r)
    l << r
  end

  def or(l, r)
    l | r
  end

  def and(l, r)
    l & r
  end

  def not(l, r)
    ~r
  end

  def to_i
    i = send(@op.downcase.to_sym, @context.evaluate(@lhs), @context.evaluate(@rhs))
    @context.instance_variable_set('@' + @dest, i)
    i
  end
end

class Circuit
  def evaluate(name_or_number)
    return name_or_number if name_or_number.is_a? Numeric
    return name_or_number.to_i if name_or_number =~ /^\d+$/ or name_or_number.is_a? Operation

    return nil if name_or_number.nil?

    evaluate(self.instance_variable_get('@' + name_or_number.to_s))
  end
end

c = Circuit.new
lines.each do |line|
  /^(?<desc>.+)\s+->\s+(?<dest>\w+)/ =~ line

  val = nil
  # Todo: create operator object
  case
    when /^\d+$/ =~ desc
      val = desc.to_i
    when /^[a-z]+$/ =~ desc
      val = desc
    when /^(?<lhs>([a-z]+|\d+))\s+(?<op>[A-Z]+)\s+(?<rhs>(\d+|[a-z]+))$/ =~ desc
      val = Operation.new(c, op, lhs, rhs, dest)
    when /^NOT\s+(?<rhs>(\d+|[a-z]+))$/ =~ desc
      val = Operation.new(c, 'not', nil, rhs, dest)
    else
      puts "Doesn't match: #{desc}"
  end

  # Assign to instance variable of the circuit...
  c.instance_variable_set('@' + dest, val)
end

puts 'Please enter the name of the wire you would like the value of and press return'
wire = gets.chomp

## Problem 1
a = Marshal.load(Marshal.dump(c))
av = a.evaluate(wire)
puts "Problem 1: value of #{wire}: #{a.evaluate(wire).to_i}"

## Problem 2
puts 'Please enter the name of the wire you would like to set to the result of the last evaluation'
bwire = gets.chomp
c.instance_variable_set('@' + bwire, av)
puts "Problem 2: value of #{wire} after changing #{bwire} to #{av}: #{c.evaluate(wire).to_i}"