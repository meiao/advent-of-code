require 'minitest/autorun'
require_relative '2025-10'

# Tests for 2025 day 10
class Test2025_10 < Minitest::Test
  def test_part1
    file_name = File.join(File.dirname(__FILE__), './input')
    input = File.open(file_name).readlines.map(&:strip)
    solver = Solver.new
    assert_equal(7, solver.solve(input))
  end

  def test_part2
   file_name = File.join(File.dirname(__FILE__), './input')
   input = File.open(file_name).readlines.map(&:strip)
   solver = Solver.new
   assert_equal(33, solver.solve2(input))
  end
end
