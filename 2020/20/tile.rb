module Direction
  NEXT = {}
  NEXT[:north] = :east
  NEXT[:east] = :south
  NEXT[:south] = :west
  NEXT[:west] = :north
end

class Tile
  def initialize(lines)
    @map = []
    @tile_no = lines.shift.split(' ')[1].to_i
    @sides = {}

    north = lines[0]
    south = lines[-1]
    west = ''
    east = ''
    lines.each do |line|
      west << line[0]
      east << line[-1]
      @map << line.strip[1..-2] # removing the first and last chars
    end

    # removing first and last lines
    @map.shift
    @map.pop

    @sides[:north] = Side.new(north)
    @sides[:east]  = Side.new(east)
    @sides[:south] = Side.new(south)
    @sides[:west]  = Side.new(west)
  end

  def tile_no
    return @tile_no
  end

  def map
    @map
  end

  def to_s
    return '<' + @tile_no + '>'
  end

  def hashes()
    hashes = []
    @sides.values.each do |side|
      hashes << side.hash()
    end
    return hashes
  end

  def hash(direction)
    @sides[direction].hash()
  end

  def rotate_to(left_hash, top_hash)
    while !(left_hash == @sides[:west].hash() && top_hash == @sides[:north].hash())
      if left_hash == @sides[:west].hash() || top_hash == @sides[:north].hash()
        flip()
      else
        rotate()
      end
    end
  end

  def flip
    temp = @sides[:north]
    @sides[:north] = @sides[:south]
    @sides[:south] = temp
    @map = @map.reverse
  end

  def rotate
    temp = @sides[:north]
    @sides[:north] = @sides[:west]
    @sides[:west] = @sides[:south]
    @sides[:south] = @sides[:east]
    @sides[:east] = temp

    next_map = []
    @map.size.times do |i|
      next_map << ''
    end
    @map.each do |line|
      line.size.times do |i|
        next_map[i].insert(0, line[i])
      end
    end
    @map = next_map
  end

  def map
    return @map
  end

  def clear_hash(hash)
    @sides.values.each do |side|
      side.clear_hash(hash)
    end
  end

  def is_corner?
    return hashes().count(-1) == 2
  end

end

class Side
  def initialize(value_str)
    hash = value_str.to_i(2)
    inverted_hash = value_str.reverse.to_i(2)
    if hash < inverted_hash
      @hash = hash
    else
      @hash = inverted_hash
    end
  end

  def hash
    return @hash
  end

  def clear_hash(hash)
    if @hash == hash
      @hash = -1
    end
  end
end
