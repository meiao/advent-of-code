class Solver
  def solve(input)
    sum = 0
    input.each do |nums|
      sum += 1 if is_triangle?(nums)
    end
    sum
  end

  def is_triangle?(nums)
    nums = nums.sort
    nums[0] + nums[1] > nums[2]
  end

  def solve2(input)
    sum = 0
    until input.empty? do
      sum += vertical_triangles(input.shift(3))
    end
    sum
  end

  def vertical_triangles(matrix)
    sum = 0
    sum += 1 if is_triangle?([matrix[0][0], matrix[1][0], matrix[2][0]])
    sum += 1 if is_triangle?([matrix[0][1], matrix[1][1], matrix[2][1]])
    sum += 1 if is_triangle?([matrix[0][2], matrix[1][2], matrix[2][2]])
    sum
  end
end

input = []
while line = gets
  input << line.split(' ').map(&:to_i)
end
solver = Solver.new
puts solver.solve(input)

# 1858 low
puts solver.solve2(input)

