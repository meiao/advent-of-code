require 'minitest/autorun'
require_relative '2022-18'

# Tests for 2022 day 18
class Test2022_18 < Minitest::Test

  def test_part1_smaller
    file_name = File.join(File.dirname(__FILE__), './input.smaller')
    input = File.open(file_name).readlines
    solver = Solver.new
    assert_equal(10, solver.solve(input))
  end

  def test_part1_small
    file_name = File.join(File.dirname(__FILE__), './input.small')
    input = File.open(file_name).readlines
    solver = Solver.new
    assert_equal(64, solver.solve(input))
  end

  def test_part1_large
   file_name = File.join(File.dirname(__FILE__), './input')
   input = File.open(file_name).readlines
   solver = Solver.new
   assert_equal(4580, solver.solve(input))
  end

  def test_part2_small
   file_name = File.join(File.dirname(__FILE__), './input.small')
   input = File.open(file_name).readlines
   solver = Solver2.new
   assert_equal(58, solver.solve(input))
  end

  def test_part2_large
   file_name = File.join(File.dirname(__FILE__), './input')
   input = File.open(file_name).readlines
   solver = Solver2.new
   assert_equal(2610, solver.solve(input))
  end
end
