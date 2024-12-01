require 'minitest/autorun'
require_relative '2022-23'

# Tests for 2022 day 23
class Test2022_23 < Minitest::Test
  def test_part1_smaller
    file_name = File.join(File.dirname(__FILE__), './input.smaller')
    input = File.open(file_name).readlines
    solver = Solver.new(input)
    assert_equal(25, solver.solve(10))
  end

  def test_part1_small
    file_name = File.join(File.dirname(__FILE__), './input.small')
    input = File.open(file_name).readlines
    solver = Solver.new(input)
    assert_equal(110, solver.solve(10))
  end

  def test_part1_large
    file_name = File.join(File.dirname(__FILE__), './input')
    input = File.open(file_name).readlines
    solver = Solver.new(input)
    assert_equal(4034, solver.solve(10))
  end

  def test_part2_small
    file_name = File.join(File.dirname(__FILE__), './input.small')
    input = File.open(file_name).readlines
    solver = Solver.new(input)
    assert_equal(20, solver.solve2)
  end

  def test_part2_large
    file_name = File.join(File.dirname(__FILE__), './input')
    input = File.open(file_name).readlines
    solver = Solver.new(input)
    assert_equal(960, solver.solve2)
  end
end
