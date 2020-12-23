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

  def hashes()
    hashes = []
    @sides.values.each do |side|
      hashes << side.smaller_hash
    end
    return hashes
  end

  def rotate
    temp = @sides[:north].rotate(:east)
    @sides[:north] = @sides[:west].rotate(:north)
    @sides[:west] = @sides[:south].rotate(:west)
    @sides[:south] = @sides[:east].rotate(:south)
    @sides[:east] = temp

    next_map = []
    @map.each do |line|
      
  end

end

class Side
  def initialize(value_str)
    @hash = value_str.to_i(2)
    @inverted_hash = value_str.reverse.to_i(2)
  end

  def rotate(to_direction)
    if to_direction == :south || :to_direction == :north
      temp = @hash
      @hash = inverted_hash
      @inverted_hash = temp
    end
    return this
  end

  def smaller_hash()
    return @hash if @hash < @inverted_hash
    return @inverted_hash
  end
end
