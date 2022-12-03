class Solver
  def initialize(matrix)
    @directions = [[0, 1], [1, 0]]
    @to_visit = []
    @visited = {}
    @visited.default = false
    @can_be_min = {}
    @can_be_min.default = true
    @matrix = matrix
    @length = matrix[0].size
    @height = matrix.size

    # adding extra items to simplify boundaries
    @matrix.each {|l| l << 10}
    bottom_arr = []
    @length.times do
      bottom_arr << 10
    end
    @matrix << bottom_arr

    p matrix
  end

  def less_than(p, dir)
    p2 = [p[0] + dir[0], p[1] + dir[1]]
    if @matrix[p[0]][p[1]] < @matrix[p2[0]][p2[1]]
      @can_be_min[p2] = false
      return true
    end
    false
  end

  def visit(p)
    less_than_right = less_than(p, [0, 1])
    less_than_down = less_than(p, [1, 0])
    if less_than_right && less_than_down && @can_be_min[p]
      p p
      return @matrix[p[0]][p[1]] + 1
    end
    return 0
  end

  def solve
    sum_min = 0
    @length.times do |col|
      @height.times do |row|
        sum_min += visit([row, col])
      end
    end
    sum_min
  end
end

lines = File.open('9-input').readlines.collect {|l| l.strip }
lines = lines.collect {|l| l.split('').collect{|n| n.to_i}}

p Solver.new(lines).solve
