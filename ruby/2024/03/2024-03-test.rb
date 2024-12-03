require 'minitest/autorun'
require_relative '2024-03'

# Tests for 2024 day 03
class Test2024_03 < Minitest::Test
  def test_part1_small
    file_name = File.join(File.dirname(__FILE__), './input.small')
    input = File.open(file_name).readlines
    solver = Solver.new
    assert_equal(161, solver.solve(input))
  end

  def test_part1_large
    file_name = File.join(File.dirname(__FILE__), './input')
    input = File.open(file_name).readlines
    solver = Solver.new
    assert_equal(179_834_255, solver.solve(input))
  end

  def test_part2_small
    file_name = File.join(File.dirname(__FILE__), './input.small2')
    input = File.open(file_name).readlines
    solver = Solver.new
    assert_equal(48, solver.solve2(input))
  end

  def test_part2_large
    file_name = File.join(File.dirname(__FILE__), './input')
    input = File.open(file_name).readlines
    solver = Solver.new
    assert_equal(80_570_939, solver.solve2(input))
  end
end
