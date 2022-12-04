require 'minitest/autorun'
require_relative '2022-04'

# Tests for 2022 day 04
class Test2022_04 < Minitest::Test
  def test_part1_small
    solver = Solver.new
    file_name = File.join(File.dirname(__FILE__), './input.small')
    input = File.open(file_name).readlines
    assert_equal(2, solver.solve(input))
  end

  def test_part1_large
    solver = Solver.new
    file_name = File.join(File.dirname(__FILE__), './input')
    input = File.open(file_name).readlines
    assert_equal(569, solver.solve(input))
  end

  def test_part2_small
    solver = Solver2.new
    file_name = File.join(File.dirname(__FILE__), './input.small')
    input = File.open(file_name).readlines
    assert_equal(4, solver.solve(input))
  end

  def test_part2_large
    solver = Solver2.new
    file_name = File.join(File.dirname(__FILE__), './input')
    input = File.open(file_name).readlines
    assert_equal(936, solver.solve(input))
  end
end
