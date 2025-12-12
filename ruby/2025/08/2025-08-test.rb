require 'minitest/autorun'
require_relative '2025-08'

# Tests for 2025 day 08
class Test2025_08 < Minitest::Test
  def test_part1
    file_name = File.join(File.dirname(__FILE__), './input')
    input = File.open(file_name).readlines.map(&:strip)
    solver = Solver.new
    assert_equal(40, solver.solve(input, 10))
  end

  def test_part2
   file_name = File.join(File.dirname(__FILE__), './input')
   input = File.open(file_name).readlines.map(&:strip)
   solver = Solver.new
   assert_equal(25272, solver.solve2(input))
  end
end
