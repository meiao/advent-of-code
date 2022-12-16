require 'minitest/autorun'
require_relative '2022-15'

# Tests for 2022 day 15
class Test2022_15 < Minitest::Test
  def test_part1_small
    file_name = File.join(File.dirname(__FILE__), './input.small')
    input = File.open(file_name).readlines
    solver = Solver.new(input)
    assert_equal(26, solver.solve(10))
  end

  def test_part1_large
   file_name = File.join(File.dirname(__FILE__), './input')
   input = File.open(file_name).readlines
   solver = Solver.new(input)
   assert_equal(5688618, solver.solve(2000000))
  end

  def test_part2_small
   file_name = File.join(File.dirname(__FILE__), './input.small')
   input = File.open(file_name).readlines
   solver = Solver.new(input)
   assert_equal(56000011, solver.solve2(20))
  end

  def test_part2_large
   file_name = File.join(File.dirname(__FILE__), './input')
   input = File.open(file_name).readlines
   solver = Solver.new(input)
   assert_equal(1, solver.solve2(4000000))
  end
end
