require 'minitest/autorun'
require_relative '2022-13'

# Tests for 2022 day 13
class Test2022_13 < Minitest::Test
  def test_compare
    solver = Solver.new
    assert_operator(solver.compare([1, 1, 3, 1, 1], [1, 1, 5, 1, 1]), :<=, -1)
    assert_operator(solver.compare([[1], [2, 3, 4]], [[1], 4]), :<=, -1)
    assert_operator(solver.compare([9], [[8, 7, 6]]), :>=, 1)
    assert_operator(solver.compare([[4, 4], 4, 4], [[4, 4], 4, 4, 4]), :<=, -1)
  end

  def test_part1_small
    file_name = File.join(File.dirname(__FILE__), './input.small')
    input = File.open(file_name).readlines
    solver = Solver.new
    assert_equal(13, solver.solve(input))
  end

  def test_part1_large
    file_name = File.join(File.dirname(__FILE__), './input')
    input = File.open(file_name).readlines
    solver = Solver.new
    assert_equal(5393, solver.solve(input))
  end

  def test_part2_small
    file_name = File.join(File.dirname(__FILE__), './input.small')
    input = File.open(file_name).readlines
    solver = Solver.new
    assert_equal(140, solver.solve2(input))
  end

  def test_part2_large
    file_name = File.join(File.dirname(__FILE__), './input')
    input = File.open(file_name).readlines
    solver = Solver.new
    assert_equal(26_712, solver.solve2(input))
  end
end
