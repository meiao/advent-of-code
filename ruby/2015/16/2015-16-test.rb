require 'minitest/autorun'
require_relative '2015-16'

# Tests for 2015 day 16
class Test2015_16 < Minitest::Test
  def test_part1_large
    file_name = File.join(File.dirname(__FILE__), './input')
    input = File.open(file_name).readlines
    solver = Solver.new(input)
    assert_equal(40, solver.solve)
  end

  def test_part2_large
    file_name = File.join(File.dirname(__FILE__), './input')
    input = File.open(file_name).readlines
    solver = Solver.new(input)
    assert_equal(1, solver.solve2)
  end
end
