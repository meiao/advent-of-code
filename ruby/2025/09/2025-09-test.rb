require 'minitest/autorun'
require_relative '2025-09'

# Tests for 2025 day 09
class Test2025_09 < Minitest::Test
  def test_part1
    file_name = File.join(File.dirname(__FILE__), './input')
    input = File.open(file_name).readlines.map(&:strip)
    solver = Solver.new
    assert_equal(50, solver.solve(input, true))
  end

  def test_part2
    file_name = File.join(File.dirname(__FILE__), './input')
    input = File.open(file_name).readlines.map(&:strip)
    solver = Solver.new
    assert_equal(24, solver.solve(input, false))
  end

  def test_cross
    solver = Solver.new
    assert_equal(false, solver.cross?([[0, 0], [2, 0]], [[0, 1], [2, 1]]))
    assert_equal(false, solver.cross?([[2, 0], [2, 2]], [[3, 1], [3, 4]]))
    assert_equal(false, solver.cross?([[2, 0], [2, 2]], [[10, 1], [15, 1]]))
    assert_equal(false, solver.cross?([[10, 1], [15, 1]], [[2, 0], [2, 2]]))
    assert_equal(true, solver.cross?([[10, 1], [15, 1]], [[12, 0], [12, 3]]))
  end
end
