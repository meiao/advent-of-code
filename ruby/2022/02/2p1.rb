lines = File.open('2-input').readlines

move_point = {
  'A'.ord => 1,
  'B'.ord => 2,
  'C'.ord => 3
}

points = 0
lines.each do |line|
  this_round = 0
  his, mine = line.split(' ').map { |c| c.ord }
  mine = mine - 'X'.ord + 'A'.ord
  this_round += move_point[mine]

  if mine == his
    this_round += 3
  elsif mine - his == 1 || mine - his == -2
    this_round += 6
  end

  points += this_round
  p this_round
end

p points
