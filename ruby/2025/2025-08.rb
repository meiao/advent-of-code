class Solver
  def solve(input)
    input.map{|line| line.split(',').map(&:to_i)}
         .combination(2)
         .map{|points| area(points[0], points[1])}
         .max
  end

  def area(p1, p2)
    ((p1[0] - p2[0] + 1) * (p1[1]- p2[1] + 1)).abs
  end
end
