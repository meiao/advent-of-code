class HashGrid
  def initialize(input, default = nil)
    @limits = [input[0].size - 1, input.size - 1]
    @map = Hash.new(default)
    (0..@limits[1]).each do |y|
      (0..@limits[0]).each do |x|
        char = input[y][x]
        @map[[x, y]] = char unless char == default
      end
    end
  end

  def [](pos)
    @map[pos]
  end

  def []=(pos, value)
    @map[pos] = value
  end

  def keys
    @map.keys
  end

  def delete(pos)
    @map.delete(pos)
  end

  attr_reader :map

  def to_s
    str = ''
    (0..@limits[1]).each do |y|
      (0..@limits[0]).each do |x|
        str += @map[[x, y]]
      end
      str += "\n"
    end
    str
  end
end
