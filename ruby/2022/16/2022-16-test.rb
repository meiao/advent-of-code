require 'minitest/autorun'
require_relative '2022-16'

# Tests for 2022 day 16
class Test2022_16 < Minitest::Test
  def test_part1_small
    file_name = File.join(File.dirname(__FILE__), './input.small')
    input = File.open(file_name).readlines
    solver = Solver.new(input)
    assert_equal(1651, solver.solve)
  end

  def test_part1_large
   file_name = File.join(File.dirname(__FILE__), './input')
   input = File.open(file_name).readlines
   solver = Solver.new(input)
   assert_equal(1940, solver.solve)
  end

  def test_part2_small
   file_name = File.join(File.dirname(__FILE__), './input.small')
   input = File.open(file_name).readlines
   solver = Solver2.new(input)
   assert_equal(1707, solver.solve)
  end

  def test_part2_large
   file_name = File.join(File.dirname(__FILE__), './input')
   input = File.open(file_name).readlines
   solver = Solver2.new(input)
   assert_equal(2469, solver.solve)
  end
end
