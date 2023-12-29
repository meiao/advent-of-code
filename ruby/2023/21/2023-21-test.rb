require 'minitest/autorun'
require_relative '2023-21'

# Tests for 2023 day 21
class Test2023_21 < Minitest::Test
  # def test_part1_small
  #   file_name = File.join(File.dirname(__FILE__), './input.small')
  #   input = File.open(file_name).readlines
  #   solver = Solver.new(input)
  #   assert_equal(16, solver.solve(6))
  # end

  # def test_part1_large
  #  file_name = File.join(File.dirname(__FILE__), './input')
  #  input = File.open(file_name).readlines
  #  solver = Solver.new(input)
  #  assert_equal(3562, solver.solve(64))
  # end

  def test_part2_small
   file_name = File.join(File.dirname(__FILE__), './input.small')
   input = File.open(file_name).readlines
   solver = Solver.new(input)
   assert_equal(16733044, solver.solve2(5000))
  end

  #def test_part2_large
  #  file_name = File.join(File.dirname(__FILE__), './input')
  #  input = File.open(file_name).readlines
  #  solver = Solver.new(input)
  #  assert_equal(1, solver.solve2(26501365))
  #end
end
