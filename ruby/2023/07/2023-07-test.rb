require 'minitest/autorun'
require_relative '2023-07'

# Tests for 2023 day 07
class Test2023_07 < Minitest::Test
  # def test_part1_small
  #   file_name = File.join(File.dirname(__FILE__), './input.small')
  #   input = File.open(file_name).readlines
  #   solver = Solver.new
  #   assert_equal(6440, solver.solve(input))
  # end

  # def test_part1_large
  #  file_name = File.join(File.dirname(__FILE__), './input')
  #  input = File.open(file_name).readlines
  #  solver = Solver.new
  #  assert_equal(247961593, solver.solve(input))
  # end

  # def test_part2_small
  #  file_name = File.join(File.dirname(__FILE__), './input.small')
  #  input = File.open(file_name).readlines
  #  solver = Solver.new
  #  assert_equal(1, solver.solve2(input))
  # end

  def test_part2_large
   file_name = File.join(File.dirname(__FILE__), './input')
   input = File.open(file_name).readlines
   solver = Solver.new
   assert_equal(1, solver.solve2(input))
  end
end
