lines = File.open('2-input').readlines

round_point = {
  'X'.ord => 0,
  'Y'.ord => 3,
  'Z'.ord => 6
}

resolution_add = {
  'X'.ord => -1,
  'Y'.ord => 0,
  'Z'.ord => 1
}

move_point = {
  ('A'.ord - 1) => 3,
  'A'.ord => 1,
  'B'.ord => 2,
  'C'.ord => 3,
  'D'.ord => 1
}

points = 0
lines.each do |line|
  this_round = 0
  his, resolution = line.split(' ').map { |c| c.ord }

  this_round += round_point[resolution]

  this_round += move_point[his + resolution_add[resolution]]

  points += this_round
  p this_round
end

p points
