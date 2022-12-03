class OceanFloor
  def initialize
    @map = {}
    @map.default = 0
  end

  def accept(p1, p2)
    xs = [p1[0], p2[0]].sort
    ys = [p1[1], p2[1]].sort
    (xs[0].upto xs[1]).each do |x|
      (ys[0].upto ys[1]).each do |y|
        @map[[x,y]] += 1
      end
    end
  end

  def count_greater_than(n)
    @map.values.filter {|v| v > n}.size
  end
end

lines = File.open('5-input').readlines.collect {|l| l.strip }

# split each line on the ->, then each pair on the comma, then convert the str to int
# so 0,9 -> 5,9 becomes [[0, 9], [5, 9]]
data = lines.map {|l| l.split(' -> ').map{|i| i.split(',').map{|n| n.to_i}}}

filtered_data = data.filter {|d| d[0][0] == d[1][0] || d[0][1] == d[1][1]}


ocean_floor = OceanFloor.new
filtered_data.each do |line|
  ocean_floor.accept(line[0], line[1])
end

p ocean_floor.count_greater_than 1
