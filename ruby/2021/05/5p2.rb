class OceanFloor
  def initialize
    @map = {}
    @map.default = 0
  end

  def accept(p1, p2)
    dir_x = -1 * (p1[0] <=> p2[0])
    dir_y = -1 * (p1[1] <=> p2[1])

    len_x = (p1[0] - p2[0]).abs
    len_y = (p1[1] - p2[1]).abs
    length = [len_x, len_y].max

    (length + 1).times do |i|
      x = p1[0] + (dir_x * i)
      y = p1[1] + (dir_y * i)
      @map[[x, y]] += 1
    end
  end

  def get_iterator(n1, n2)
    return n1.method(:upto) if n1 <= n2

    n1.method(:downto)
  end

  def count_greater_than(n)
    p(@map.values.filter { |v| v > n })
    @map.values.filter { |v| v > n }.size
  end
end

lines = File.open('5-input').readlines.collect { |l| l.strip }

# split each line on the ->, then each pair on the comma, then convert the str to int
# so 0,9 -> 5,9 becomes [[0, 9], [5, 9]]
data = lines.map { |l| l.split(' -> ').map { |i| i.split(',').map { |n| n.to_i } } }
ocean_floor = OceanFloor.new
data.each do |line|
  p line
  ocean_floor.accept(line[0], line[1])
end

p ocean_floor
p ocean_floor.count_greater_than 1
