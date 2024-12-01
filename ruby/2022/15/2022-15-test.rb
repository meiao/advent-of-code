require 'minitest/autorun'
require_relative '2022-15'

# Tests for 2022 day 15
class Test2022_15 < Minitest::Test
  def test_part1_small
    file_name = File.join(File.dirname(__FILE__), './input.small')
    input = File.open(file_name).readlines
    solver = Solver.new(input)
    assert_equal(26, solver.solve(10))
  end

  def test_part1_large
    file_name = File.join(File.dirname(__FILE__), './input')
    input = File.open(file_name).readlines
    solver = Solver.new(input)
    assert_equal(5_688_618, solver.solve(2_000_000))
  end

  def test_part2_small
    file_name = File.join(File.dirname(__FILE__), './input.small')
    input = File.open(file_name).readlines
    solver = Solver.new(input)
    assert_equal(56_000_011, solver.solve2(20))
  end

  def test_part2_large
    file_name = File.join(File.dirname(__FILE__), './input')
    input = File.open(file_name).readlines
    solver = Solver.new(input)
    assert_equal(1, solver.solve2(4_000_000))
  end
end
