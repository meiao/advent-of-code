lines = File.open('2-input').readlines

depth = 0
forward = 0
aim = 0

lines.each do |line|
  cmd, value = line.split(' ')
  case cmd
  when 'forward'
    forward += value.to_i
    depth += aim * value.to_i
    depth = 0 if depth < 0
  when 'down'
    aim += value.to_i
  when 'up'
    aim -= value.to_i
  end
end

puts depth * forward
