require 'minitest/autorun'
require_relative '2022-11'

# Tests for 2022 day 11
class Test2022_11 < Minitest::Test
  def test_part1_small
    file_name = File.join(File.dirname(__FILE__), './input.small')
    input = File.open(file_name).readlines
    solver = Solver.new
    assert_equal(10_605, solver.solve(input, 20, 3))
  end

  def test_part1_large
    file_name = File.join(File.dirname(__FILE__), './input')
    input = File.open(file_name).readlines
    solver = Solver.new
    assert_equal(51_075, solver.solve(input, 20, 3))
  end

  def test_part2_small
    file_name = File.join(File.dirname(__FILE__), './input.small')
    input = File.open(file_name).readlines
    solver = Solver.new
    assert_equal(2_713_310_158, solver.solve(input, 10_000, 1))
  end

  def test_part2_large
    file_name = File.join(File.dirname(__FILE__), './input')
    input = File.open(file_name).readlines
    solver = Solver.new
    assert_equal(11_741_456_163, solver.solve(input, 10_000, 1))
  end
end
