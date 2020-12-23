lines = File.open('12.input.filtered.numbers').readlines

puts lines[0].split(',').map{|n| n.to_i}.sum
