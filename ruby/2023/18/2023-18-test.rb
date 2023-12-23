require 'minitest/autorun'
require_relative '2023-18'

# Tests for 2023 day 18
class Test2023_18 < Minitest::Test
  def test_part1_small
    file_name = File.join(File.dirname(__FILE__), './input.small')
    input = File.open(file_name).readlines
    solver = Solver.new
    assert_equal(62, solver.solve(input))
  end

  def test_part1_large
   file_name = File.join(File.dirname(__FILE__), './input')
   input = File.open(file_name).readlines
   solver = Solver.new
   assert_equal(31171, solver.solve(input))
  end

  def test_part2_small
   file_name = File.join(File.dirname(__FILE__), './input.small')
   input = File.open(file_name).readlines
   solver = Solver.new
   assert_equal(952408144115, solver.solve2(input))
  end

  def test_part2_large
   file_name = File.join(File.dirname(__FILE__), './input')
   input = File.open(file_name).readlines
   solver = Solver.new
   assert_equal(131431655002266, solver.solve2(input))
  end
end
