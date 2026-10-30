require 'minitest/autorun'
require_relative '2021-02'

# Tests for 2021 day 02
class Test2021_02 < Minitest::Test
  def test_part1
    file_name = File.join(File.dirname(__FILE__), './input')
    input = File.readlines(file_name).map(&:strip)
    solver = Solver.new
    assert_equal(150, solver.solve(input))
  end

  def test_part2
    file_name = File.join(File.dirname(__FILE__), './input')
    input = File.readlines(file_name).map(&:strip)
    solver = Solver.new
    assert_equal(900, solver.solve2(input))
  end
end
