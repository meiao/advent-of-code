require 'minitest/autorun'
require_relative '2024-18'

# Tests for 2024 day 18
class Test2024_18 < Minitest::Test
  def test_part1_small
    file_name = File.join(File.dirname(__FILE__), './input.small')
    input = File.open(file_name).readlines.map(&:strip)
    solver = Solver.new
    assert_equal(22, solver.solve(input, 12, [6, 6]))
  end

  def test_part1_large
    file_name = File.join(File.dirname(__FILE__), './input')
    input = File.open(file_name).readlines.map(&:strip)
    solver = Solver.new
    assert_equal(454, solver.solve(input, 1024, [70, 70]))
  end

  def test_part2_small
    file_name = File.join(File.dirname(__FILE__), './input.small')
    input = File.open(file_name).readlines.map(&:strip)
    solver = Solver.new
    assert_equal('6,1', solver.solve2(input, [6, 6]))
  end

  def test_part2_large
    file_name = File.join(File.dirname(__FILE__), './input')
    input = File.open(file_name).readlines.map(&:strip)
    solver = Solver.new
    assert_equal('8,51', solver.solve2(input, [70, 70]))
  end
end
