require 'minitest/autorun'
require_relative '2025-05'

# Tests for 2025 day 05
class Test2025_05 < Minitest::Test
  def test_part1
    solver = Solver.new
    ranges, ingredients = read_input
    assert_equal(3, solver.solve(ranges, ingredients))
  end

  def test_part2
    solver = Solver.new
    ranges, = read_input
    assert_equal(14, solver.solve2(ranges))
  end

  def read_input
    file_name = File.join(File.dirname(__FILE__), './input')
    input = File.open(file_name).readlines.join
    input.split("\n\n").map { |section| section.split("\n") }
  end
end
