require 'minitest/autorun'
require_relative '2023-10'

# Tests for 2023 day 10
class Test2023_10 < Minitest::Test
  def test_part1_small
    file_name = File.join(File.dirname(__FILE__), './input.small')
    input = File.open(file_name).readlines
    solver = Solver.new
    assert_equal(8, solver.solve(input))
  end

  def test_part1_large
    file_name = File.join(File.dirname(__FILE__), './input')
    input = File.open(file_name).readlines
    solver = Solver.new
    assert_equal(6828, solver.solve(input))
  end

  def test_part2_small
    file_name = File.join(File.dirname(__FILE__), './input.small')
    input = File.open(file_name).readlines
    solver = Solver.new
    assert_equal(1, solver.solve2(input))
  end

  def test_part2_small2
    file_name = File.join(File.dirname(__FILE__), './input.small2')
    input = File.open(file_name).readlines
    solver = Solver.new
    assert_equal(4, solver.solve2(input))
  end

  def test_part2_small3
    file_name = File.join(File.dirname(__FILE__), './input.small3')
    input = File.open(file_name).readlines
    solver = Solver.new
    assert_equal(8, solver.solve2(input))
  end

  def test_part2_large
    file_name = File.join(File.dirname(__FILE__), './input')
    input = File.open(file_name).readlines
    solver = Solver.new
    assert_equal(1, solver.solve2(input))
  end
end
