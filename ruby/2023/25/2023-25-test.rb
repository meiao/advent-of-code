require 'minitest/autorun'
require_relative '2023-25'

# Tests for 2023 day 25
class Test2023_25 < Minitest::Test
  def test_part1_small
    file_name = File.join(File.dirname(__FILE__), './input.small')
    input = File.open(file_name).readlines
    solver = Solver.new
    assert_equal(54, solver.solve(input))
  end

  def test_part1_small2
    file_name = File.join(File.dirname(__FILE__), './input.small2')
    input = File.open(file_name).readlines
    solver = Solver.new
    assert_equal(60, solver.solve(input))
  end

  def test_part1_large
    file_name = File.join(File.dirname(__FILE__), './input')
    input = File.open(file_name).readlines
    solver = Solver.new
    assert_equal(562_772, solver.solve(input))
  end
end
