require 'minitest/autorun'
require_relative '2023-08'

# Tests for 2023 day 08
class Test2023_08 < Minitest::Test
  def test_part1_small
    file_name = File.join(File.dirname(__FILE__), './input.small')
    input = File.open(file_name).readlines
    solver = Solver.new
    assert_equal(6, solver.solve(input))
  end

  def test_part1_large
   file_name = File.join(File.dirname(__FILE__), './input')
   input = File.open(file_name).readlines
   solver = Solver.new
   assert_equal(1, solver.solve(input))
  end

  def test_part2_small
   file_name = File.join(File.dirname(__FILE__), './input.small2')
   input = File.open(file_name).readlines
   solver = Solver.new
   assert_equal(6, solver.solve2(input))
  end

  # part 2 would take too long to brute force
  # so the period of the cycle for each ghost was calculated
  # and with some extra math and help from the input
  # it was discovered that they would converge when the step was 0 mod cycle size

  # def test_part2_large
  #  file_name = File.join(File.dirname(__FILE__), './input')
  #  input = File.open(file_name).readlines
  #  solver = Solver.new
  #  assert_equal(1, solver.solve2(input))
  # end
end
