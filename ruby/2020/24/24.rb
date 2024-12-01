lines = File.open('24.input').readlines

map = {}

directions = {}
directions['w'] = [-2, 0]
directions['sw'] = [-1, -1]
directions['nw'] = [-1, 1]
directions['e'] = [2, 0]
directions['se'] = [1, -1]
directions['ne'] = [1, 1]

lines.each do |line|
  pos = [0, 0]
  line.strip.split(' ') do |dir|
    pos[0] += directions[dir][0]
    pos[1] += directions[dir][1]
  end
  if map[pos].nil?
    map[pos] = true
  else
    map.delete(pos)
  end
end

puts map.values.count(true)

100.times do
  white_tiles = {}
  next_map = {}

  # checking black tiles
  map.keys.each do |pos|
    black_count = 0
    directions.values.each do |dir|
      xy = [pos[0] + dir[0], pos[1] + dir[1]]
      if map[xy] == true
        black_count += 1
      else
        white_tiles[xy] = true
      end
    end

    next_map[pos] = true if [1, 2].include?(black_count)
  end

  # checking white tiles

  white_tiles.keys.each do |pos|
    black_count = 0
    directions.values.each do |dir|
      xy = [pos[0] + dir[0], pos[1] + dir[1]]
      black_count += 1 if map[xy] == true
    end

    next_map[pos] = true if black_count == 2
  end

  map = next_map
end

puts map.size
