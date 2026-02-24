require 'minitest/autorun'
require_relative '2025-09'

# Tests for 2025 day 09
class Test2025_09 < Minitest::Test
  def test_part1
    file_name = File.join(File.dirname(__FILE__), './input')
    input = File.open(file_name).readlines.map(&:strip)
    solver = Solver.new
    assert_equal(50, solver.solve(input, true))
  end

  def test_part2
   file_name = File.join(File.dirname(__FILE__), './input')
   input = File.open(file_name).readlines.map(&:strip)
   solver = Solver.new
   assert_equal(24, solver.solve(input, false))
  end
end
