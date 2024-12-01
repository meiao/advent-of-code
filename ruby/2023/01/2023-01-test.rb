require 'minitest/autorun'
require_relative '2023-01'

# Tests for 2023 day 01
class Test2023_01 < Minitest::Test
  def test_part1_small
    file_name = File.join(File.dirname(__FILE__), './input.small')
    input = File.open(file_name).readlines
    solver = Solver.new
    assert_equal(142, solver.solve(input))
  end

  def test_part1_large
    file_name = File.join(File.dirname(__FILE__), './input')
    input = File.open(file_name).readlines
    solver = Solver.new
    assert_equal(1, solver.solve(input))
  end

  def test_part2_small
    file_name = File.join(File.dirname(__FILE__), './input.small.2')
    input = File.open(file_name).readlines
    solver = Solver.new
    assert_equal(281, solver.solve2(input))
  end

  def test_part2_large
    file_name = File.join(File.dirname(__FILE__), './input')
    input = File.open(file_name).readlines
    solver = Solver.new
    assert_equal(1, solver.solve2(input))
  end
end
