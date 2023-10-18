require 'minitest/autorun'
require_relative '2015-17'

# Tests for 2015 day 17
class Test2015_17 < Minitest::Test
  def test_part1_small
    file_name = File.join(File.dirname(__FILE__), './input.small')
    input = File.open(file_name).readlines
    solver = Solver.new
    assert_equal(4, solver.solve(input, 25))
  end

  def test_part1_large
   file_name = File.join(File.dirname(__FILE__), './input.sorted')
   input = File.open(file_name).readlines
   solver = Solver.new
   assert_equal(1638, solver.solve(input, 150))
  end

  def test_part2_small
   file_name = File.join(File.dirname(__FILE__), './input.small')
   input = File.open(file_name).readlines
   solver = Solver.new
   assert_equal(3, solver.solve2(input, 25))
  end

  def test_part2_large
   file_name = File.join(File.dirname(__FILE__), './input.sorted')
   input = File.open(file_name).readlines
   solver = Solver.new
   assert_equal(1, solver.solve2(input, 150))
  end
end
