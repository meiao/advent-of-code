require 'minitest/autorun'
require_relative '2021-24'

# Tests for 2021 day 24
class Test2021_24 < Minitest::Test
  def test_part1_small
    file_name = File.join(File.dirname(__FILE__), './input')
    input = File.open(file_name).readlines
    solver = Solver.new
    assert_equal(8, solver.solve1(input))
  end

  def test_part2_small
    file_name = File.join(File.dirname(__FILE__), './input')
    input = File.open(file_name).readlines
    solver = Solver.new
    assert_equal(2, solver.solve2(input))
  end

end
