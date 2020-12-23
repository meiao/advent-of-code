str_lines = File.open('3.input').readlines

trees1 = 0
trees3 = 0
trees5 = 0
trees7 = 0
trees2 = 0
str_lines.each_index do |index|
  line = str_lines[index]
  line.strip!
  trees1 += 1 if line[(1*index)%line.size] == '#'
  trees3 += 1 if line[(3*index)%line.size] == '#'
  trees5 += 1 if line[(5*index)%line.size] == '#'
  trees7 += 1 if line[(7*index)%line.size] == '#'
  trees2 += 1 if index % 2 == 0 && line[(index/2)%line.size] == '#'
end

puts trees1, trees3, trees5, trees7, trees2
puts trees1 * trees3 * trees5 * trees7 * trees2
