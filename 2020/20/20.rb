require './tile'

lines = File.open('20.input').readlines

tiles = {}

while !lines.empty?
  group = []
  line = lines.shift.strip
  while line != nil && !line.empty?
    group << line
    line = lines.shift
    line = line.strip if line != nil
  end
  tile = Tile.new(group)
  tiles[tile.tile_no] = tile
end

hashes = {}
tiles.values.each do |tile|
  tile_hashes = tile.hashes()
  tile_no = tile.tile_no
  tile_hashes.each do |hash|
    hashes[hash] = [] if hashes[hash] == nil
    hashes[hash] << tile_no
  end
end

puts hashes.to_s
