require 'minitest/autorun'
require_relative '2022-07'

# Tests for 2022 day 07
class Test2022_07 < Minitest::Test
  def test_part1_small
    solver = Solver.new
    file_name = File.join(File.dirname(__FILE__), './input.small')
    input = File.open(file_name).readlines
    assert_equal(95_437, solver.solve(input))
  end

  def test_part1_large
    solver = Solver.new
    file_name = File.join(File.dirname(__FILE__), './input')
    input = File.open(file_name).readlines
    assert_equal(1_390_824, solver.solve(input))
  end

  def test_part2_small
    solver = Solver.new
    file_name = File.join(File.dirname(__FILE__), './input.small')
    input = File.open(file_name).readlines
    assert_equal(24_933_642, solver.solve2(input))
  end

  def test_part2_large
    solver = Solver.new
    file_name = File.join(File.dirname(__FILE__), './input')
    input = File.open(file_name).readlines
    assert_equal(7_490_863, solver.solve2(input))
  end
end
