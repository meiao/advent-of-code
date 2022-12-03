lines = File.open('6.input.single_line').readlines

sum = 0
lines.each do |line|
  sum += line.strip.split('').uniq.count
end

puts sum


lines = File.open('6.input.single_line.separated').readlines

sum = 0
lines.each do |line|
  map = {}
  ('a'..'z').each do |char|
    map[char] = 0
  end
  map['|'] = 0
  line.strip.split('').each do |char|
    map[char] = map[char] + 1
  end

  count = map['|']
  ('a'..'z').each do |char|
    sum += 1 if map[char] == count
  end
end

puts sum
