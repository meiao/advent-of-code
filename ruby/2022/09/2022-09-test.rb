require 'minitest/autorun'
require_relative '2022-09'

# Tests for 2022 day 09
class Test2022_09 < Minitest::Test
  def test_part1_small
    file_name = File.join(File.dirname(__FILE__), './input.small')
    input = File.open(file_name).readlines
    solver = Solver.new
    assert_equal(13, solver.solve(input))
  end

  def test_part1_large
    file_name = File.join(File.dirname(__FILE__), './input')
    input = File.open(file_name).readlines
    solver = Solver.new
    assert_equal(13, solver.solve(input))
  end

  #def test_part2_small
  #  solver = Solver2.new
  #  assert_equal(1, solver.solve)
  #end

  #def test_part2_large
  #  solver = Solver2.new
  #  assert_equal(1, solver.solve)
  #end
end
