require 'minitest/autorun'
require_relative '2025-06'

# Tests for 2025 day 06
class Test2025_06 < Minitest::Test
  def test_part1
    file_name = File.join(File.dirname(__FILE__), './input')
    input = File.open(file_name).readlines.map(&:strip)
    solver = Solver.new
    assert_equal(4_277_556, solver.solve(input))
  end

  def test_part2
    file_name = File.join(File.dirname(__FILE__), './input')
    input = File.open(file_name).readlines
    solver = Solver.new
    assert_equal(3_263_827, solver.solve2(input))
  end
end
