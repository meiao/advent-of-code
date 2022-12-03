lines = File.open('1-input').readlines

max = 0
current = 0
lines.each do |line|
  if line == "\n"
    max = current if current > max
    current = 0
  else
    current += line.to_i
  end
end

puts max
