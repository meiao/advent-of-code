require 'minitest/autorun'
require_relative '2023-20'

# Tests for 2023 day 20
class Test2023_20 < Minitest::Test
  def test_part1_small
    file_name = File.join(File.dirname(__FILE__), './input.small')
    input = File.open(file_name).readlines
    solver = Solver.new(input)
    assert_equal(32000000, solver.solve)
  end

  def test_part1_small2
    file_name = File.join(File.dirname(__FILE__), './input.small2')
    input = File.open(file_name).readlines
    solver = Solver.new(input)
    assert_equal(11687500, solver.solve)
  end

  def test_part1_large
   file_name = File.join(File.dirname(__FILE__), './input')
   input = File.open(file_name).readlines
   solver = Solver.new(input)
   assert_equal(684125385, solver.solve)
  end

  #def test_part2_small
  #  file_name = File.join(File.dirname(__FILE__), './input.small')
  #  input = File.open(file_name).readlines
  #  solver = Solver.new
  #  assert_equal(1, solver.solve2(input))
  #end

  #def test_part2_large
  #  file_name = File.join(File.dirname(__FILE__), './input')
  #  input = File.open(file_name).readlines
  #  solver = Solver.new
  #  assert_equal(1, solver.solve2(input))
  #end
end
