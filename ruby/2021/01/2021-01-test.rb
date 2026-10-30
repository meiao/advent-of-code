require 'minitest/autorun'
require_relative '2021-01'

# Tests for 2021 day 01
class Test2021_01 < Minitest::Test
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
    assert_equal(5, solver.solve2(input))
  end
end
