require 'minitest/autorun'
require_relative '2025-04'

# Tests for 2025 day 04
class Test2025_04 < Minitest::Test
  def test_part1
    file_name = File.join(File.dirname(__FILE__), './input')
    input = File.open(file_name).readlines.map(&:strip)
    solver = Solver.new
    assert_equal(13, solver.solve(input, false))
  end

  def test_part2
    file_name = File.join(File.dirname(__FILE__), './input')
    input = File.open(file_name).readlines.map(&:strip)
    solver = Solver.new
    assert_equal(43, solver.solve(input, true))
  end
end
