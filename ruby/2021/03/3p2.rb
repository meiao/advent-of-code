lines = File.open('3-input').readlines.collect { |l| l.strip }

def count_ones(row, lines)
  sum = 0
  lines.length.times do |i|
    sum += lines[i][row].to_i
  end
  sum
end

def most_common(row, lines)
  puts lines
  puts count_ones(row, lines).to_s + ' ' + (lines.length / 2).to_s
  return '1' if count_ones(row, lines) >= ((lines.length + 1) / 2).floor

  '0'
end

def least_common(row, lines)
  return '1' if count_ones(row, lines) < ((lines.length + 1) / 2).floor

  '0'
end

def keep_only(lines, row, char)
  lines.select { |l| l[row] == char }
end

lines_kept = lines
lines.length.times do |row|
  lines_kept = keep_only(lines_kept, row, most_common(row, lines_kept))
  break if lines_kept.length == 1
end
oxygen_rate = lines_kept[0]

lines_kept = lines
lines.length.times do |row|
  lines_kept = keep_only(lines_kept, row, least_common(row, lines_kept))
  break if lines_kept.length == 1
end
co2_rate = lines_kept[0]

puts oxygen_rate
puts co2_rate
puts oxygen_rate.to_i(2) * co2_rate.to_i(2)
