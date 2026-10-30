lines = File.readlines('12.input.filtered.numbers')

puts lines[0].split(',').map { |n| n.to_i }.sum
