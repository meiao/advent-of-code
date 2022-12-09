require 'minitest/autorun'
require_relative '2022-08'

# Tests for 2022 day 08
class Test2022_08 < Minitest::Test
  def test_part1_small
    file_name = File.join(File.dirname(__FILE__), './input.small')
    input = File.open(file_name).readlines
    solver = Solver.new(input)
    assert_equal(21, solver.solve)
  end

  def test_part1_large
    file_name = File.join(File.dirname(__FILE__), './input')
    input = File.open(file_name).readlines
    solver = Solver.new(input)
    assert_equal(1647, solver.solve)
  end

  def test_part2_small
    file_name = File.join(File.dirname(__FILE__), './input.small')
    input = File.open(file_name).readlines
    solver = Solver.new(input)
    assert_equal(8, solver.solve2)
  end

  def test_part2_large
    file_name = File.join(File.dirname(__FILE__), './input')
    input = File.open(file_name).readlines
    solver = Solver.new(input)
    assert_equal(392080, solver.solve2)
  end
end
