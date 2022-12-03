require 'minitest/autorun'
require_relative '2022-03'

# Tests for 2022 day 03
class Test2022_03 < Minitest::Test
  def test_part1_small
    solver = Solver.new
    file_name = File.join(File.dirname(__FILE__), './input.small')
    input = File.open(file_name).readlines
    assert_equal(157, solver.solve(input))
  end

  def test_part1_large
    solver = Solver.new
    file_name = File.join(File.dirname(__FILE__), './input')
    input = File.open(file_name).readlines
    assert_equal(7875, solver.solve(input))
  end

  def test_part2_small
    solver = Solver2.new
    file_name = File.join(File.dirname(__FILE__), './input.small')
    input = File.open(file_name).readlines
    assert_equal(70, solver.solve(input))
  end

  def test_part2_large
    solver = Solver2.new
    file_name = File.join(File.dirname(__FILE__), './input')
    input = File.open(file_name).readlines
    assert_equal(2479, solver.solve(input))
  end
end
