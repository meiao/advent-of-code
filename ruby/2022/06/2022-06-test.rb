require 'minitest/autorun'
require_relative '2022-06'

# Tests for 2022 day 06
class Test2022_06 < Minitest::Test
  def test_part1_small
    solver = Solver.new
    file_name = File.join(File.dirname(__FILE__), './input.small')
    input = File.open(file_name).readlines
    assert_equal(11, solver.solve(input, 4))
  end

  def test_part1_large
    solver = Solver.new
    file_name = File.join(File.dirname(__FILE__), './input')
    input = File.open(file_name).readlines
    assert_equal(1034, solver.solve(input, 4))
  end

  def test_part2_small
    solver = Solver.new
    file_name = File.join(File.dirname(__FILE__), './input.small')
    input = File.open(file_name).readlines
    assert_equal(26, solver.solve(input, 14))
  end

  def test_part2_large
    solver = Solver.new
    file_name = File.join(File.dirname(__FILE__), './input')
    input = File.open(file_name).readlines
    assert_equal(2472, solver.solve(input, 14))
  end
end
