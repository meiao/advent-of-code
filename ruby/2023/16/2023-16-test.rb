require 'minitest/autorun'
require_relative '2023-16'

# Tests for 2023 day 16
class Test2023_16 < Minitest::Test
  def test_part1_small
    file_name = File.join(File.dirname(__FILE__), './input.small')
    input = File.open(file_name).readlines
    solver = Solver.new
    assert_equal(46, solver.solve(input))
  end

  def test_part1_large
   file_name = File.join(File.dirname(__FILE__), './input')
   input = File.open(file_name).readlines
   solver = Solver.new
   assert_equal(7067, solver.solve(input))
  end

  def test_part2_small
   file_name = File.join(File.dirname(__FILE__), './input.small')
   input = File.open(file_name).readlines
   solver = Solver.new
   assert_equal(1, solver.solve2(input))
  end

  def test_part2_large
   file_name = File.join(File.dirname(__FILE__), './input')
   input = File.open(file_name).readlines
   solver = Solver.new
   assert_equal(7324, solver.solve2(input))
  end
end
