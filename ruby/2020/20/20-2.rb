require './tile'
require 'pry'

lines = File.open('20.input').readlines

def is_square(array)
  return false if array.size == 1

  array.size == 12 && array[11].size == 12
end

tiles = {}

until lines.empty?
  group = []
  line = lines.shift.strip
  while !line.nil? && !line.empty?
    group << line
    line = lines.shift
    line = line.strip unless line.nil?
  end
  tile = Tile.new(group)
  tiles[tile.tile_no] = tile
end

hashes = {}
tiles.values.each do |tile|
  tile_hashes = tile.hashes
  tile_no = tile.tile_no
  tile_hashes.each do |hash|
    hashes[hash] = [] if hashes[hash].nil?
    hashes[hash] << tile_no
  end
end

hashes.keys.each do |hash|
  tile_nos = hashes[hash]
  if tile_nos.size == 1
    tiles[tile_nos[0]].clear_hash(hash)
    hashes
  end
end

first_corner = nil
tiles.keys.each do |tile_no|
  if tiles[tile_no].is_corner?
    first_corner = tiles[tile_no]
    break
  end
end

tile_map = []
tile_map << []
tile_map[0] << first_corner
first_corner.hashes.each do |hash|
  next if hash == -1

  hashes[hash].delete(first_corner.tile_no)
end

first_corner.rotate_to(-1, -1)

while true

  top_hash = -1
  left_hash = -1
  search_hash = -1
  y = tile_map.size - 1
  x = tile_map[y].size

  if y != 0
    top_hash = tile_map[y - 1][x].hash(:south)
    search_hash = top_hash
  end
  if x != 0
    left_hash = tile_map[y][x - 1].hash(:east)
    search_hash = left_hash
  end

  tile_no = hashes[search_hash][0]
  tile = tiles[tile_no]
  tile.rotate_to(left_hash, top_hash)
  tile_map[y] << tile

  tile.hashes.each do |hash|
    next if hash == -1

    hashes[hash].delete(tile.tile_no)
  end

  break if is_square(tile_map)

  tile_map << [] if tile.hash(:east) == -1

end

map = []
map << '0000000000000000000000000'
tile_map.reverse.each do |row|
  row[0].map.size.times do
    map.unshift('0')
  end

  row.each do |tile|
    tile.map.each_index do |index|
      map[index] << tile.map[index]
    end
  end
end
map.unshift('0000000000000000000000000')

map.each do |line|
  line << '0'
end

map.unshift('Tile 42:')

tile42 = Tile.new(map)

puts tile42.map

monster = [
  [0, 0],
  [1, 1],
  [4, 1],
  [5, 0],
  [6, 0],
  [7, 1],
  [10, 1],
  [11, 0],
  [12, 0],
  [13, 1],
  [16, 1],
  [17, 0],
  [18, -1],
  [18, 0],
  [19, 0]
]

def check_monster(x, y, map, monster)
  monster.each do |pos|
    return false if map[y + pos[1]][x + pos[0]] == '0'
  end
  true
end

def mark_monster(x, y, map, monster)
  monster.each do |pos|
    map[y + pos[1]][x + pos[0]] = map[y + pos[1]][x + pos[0]].next
  end
end

8.times do |rot|
  tile42.flip if rot == 4
  map = tile42.map
  (0..77).each do |x|
    (1..(map.size - 2)).each do |y|
      mark_monster(x, y, map, monster) if check_monster(x, y, map, monster)
    end
  end
  tile42.rotate
end

puts tile42.map.join.count('1')
