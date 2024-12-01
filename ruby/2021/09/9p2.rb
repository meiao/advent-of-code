class Solver
  def initialize(matrix)
    @can_be_min = {}
    @can_be_min.default = true
    @matrix = matrix
    @length = matrix[0].size
    @height = matrix.size
    @min_points = []

    # adding extra items to simplify boundaries
    @matrix.each do |l|
      l << 9
      l.insert(0, 9)
    end
    limit_arr = []
    (@length + 2).times do
      limit_arr << 9
    end
    @matrix.insert(0, limit_arr)
    @matrix << limit_arr

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
    @min_points << p if less_than_right && less_than_down && @can_be_min[p]
  end

  def basin_size(min)
    points_to_check = [min]
    basin = {}
    basin.default = false
    until points_to_check.empty?
      p = points_to_check.shift
      next if @matrix[p[0]][p[1]] == 9

      basin[p] = true
      [[0, 1], [0, -1], [1, 0], [-1, 0]].each do |dir|
        next_p = [p[0] + dir[0], p[1] + dir[1]]
        next if basin[next_p]

        points_to_check << next_p
      end
    end
    basin.keys.size
  end

  def solve
    @length.times do |col|
      @height.times do |row|
        visit([row + 1, col + 1])
      end
    end

    basin_sizes = @min_points.map { |p| basin_size(p) }.sort

    basin_sizes[-1] * basin_sizes[-2] * basin_sizes[-3]
  end
end

lines = File.open('9-input').readlines.collect { |l| l.strip }
lines = lines.collect { |l| l.split('').collect { |n| n.to_i } }

p Solver.new(lines).solve
