direction_map = {}
direction_map[[0, 1]] = {}
direction_map[[0, 1]][90] = [1, 0]
direction_map[[0, 1]][180] = [0, -1]
direction_map[[0, 1]][270] = [-1, 0]

direction_map[[0, -1]] = {}
direction_map[[0, -1]][90] = [-1, 0]
direction_map[[0, -1]][180] = [0, 1]
direction_map[[0, -1]][270] = [1, 0]

direction_map[[1, 0]] = {}
direction_map[[1, 0]][90] = [0, -1]
direction_map[[1, 0]][180] = [-1, 0]
direction_map[[1, 0]][270] = [0, 1]

direction_map[[-1, 0]] = {}
direction_map[[-1, 0]][90] = [0, 1]
direction_map[[-1, 0]][180] = [1, 0]
direction_map[[-1, 0]][270] = [0, -1]

lines = File.open('12.input').readlines

direction = [1, 0]
pos = [0, 0]

lines.each do |line|
  action, value = line.split(' ')
  value = value.to_i

  if action == 'R'
    direction = direction_map[direction][value]
  elsif action == 'N'
    pos[1] +=  value
  elsif action == 'E'
    pos[0] += value
  elsif action == 'S'
    pos[1] -=  value
  elsif action == 'W'
    pos[0] -= value
  elsif action == 'F'
    pos[0] += direction[0] * value
    pos[1] += direction[1] * value
  end

  puts '[' + pos[0].to_s + ',' + pos[1].to_s + ']'
  puts '      [' + direction[0].to_s + ',' + direction[1].to_s + ']'

end

puts pos[0].abs + pos[1].abs


def rotate(waypoint, degrees)
  if degrees == 90
    return [waypoint[1], -waypoint[0]]
  elsif degrees == 180
    return [-waypoint[0], -waypoint[1]]
  elsif degrees == 270
    return [-waypoint[1], waypoint[0]]
  end
end

pos = [0, 0]
waypoint = [10, 1]
lines.each do |line|
  action, value = line.split(' ')
  value = value.to_i

  if action == 'R'
    waypoint = rotate(waypoint, value)
  elsif action == 'N'
    waypoint[1] +=  value
  elsif action == 'E'
    waypoint[0] += value
  elsif action == 'S'
    waypoint[1] -=  value
  elsif action == 'W'
    waypoint[0] -= value
  elsif action == 'F'
    mv0 = (waypoint[0]) * value
    mv1 = (waypoint[1]) * value
    pos[0] += mv0
    pos[1] += mv1
  end

  puts '[' + pos[0].to_s + ',' + pos[1].to_s + ']'
  puts '      [' + waypoint[0].to_s + ',' + waypoint[1].to_s + ']'

end

puts pos[0].abs + pos[1].abs
