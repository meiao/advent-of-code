lines = File.open('2-input').readlines

depth = 0
forward = 0

lines.each do |line|
  cmd, value = line.split(' ')
  case cmd
  when 'forward'
    forward += value.to_i
  when 'down'
    depth += value.to_i
  when 'up'
    depth -= value.to_i
    depth = 0 if depth < 0
  end
end

puts depth * forward
