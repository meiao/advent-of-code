require 'minitest/autorun'
require_relative '2022-24'

# Tests for 2022 day 24
class Test2022_24 < Minitest::Test
  def test_part1_small
    file_name = File.join(File.dirname(__FILE__), './input.small')
    input = File.open(file_name).readlines
    solver = Solver.new(input)
    assert_equal(18, solver.solve)
  end

  def test_part1_large
    file_name = File.join(File.dirname(__FILE__), './input')
    input = File.open(file_name).readlines
    solver = Solver.new(input)
    assert_equal(277, solver.solve)
  end

  def test_part2_small
    file_name = File.join(File.dirname(__FILE__), './input.small')
    input = File.open(file_name).readlines
    solver = Solver.new(input)
    assert_equal(54, solver.solve2(18))
  end

  def test_part2_large
    file_name = File.join(File.dirname(__FILE__), './input')
    input = File.open(file_name).readlines
    solver = Solver.new(input)
    assert_equal(877, solver.solve2(277))
  end
end
