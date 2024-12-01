lines = File.open('2-input').readlines

def is_valid(line)
  rule, pass = line.split(':')
  num_rule, char = rule.split(' ')
  min, max = num_rule.split('-')
  occurrences = pass.count(char.strip)
  min.to_i <= occurrences && occurrences <= max.to_i
end

count = 0
lines.each do |line|
  count += 1 if is_valid(line)
end

puts count

def is_valid2(line)
  rule, pass = line.split(':')
  num_rule, char = rule.split(' ')
  index1, index2 = num_rule.split('-')
  pass.strip!
  char.strip!
  (pass[index1.to_i - 1] == char) ^ (pass[index2.to_i - 1] == char)
end

count = 0
lines.each do |line|
  count += 1 if is_valid2(line)
end

puts count
