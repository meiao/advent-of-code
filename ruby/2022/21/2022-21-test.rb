require 'minitest/autorun'
require_relative '2022-21'

# Tests for 2022 day 21
class Test2022_21 < Minitest::Test
  def test_part1_small
    file_name = File.join(File.dirname(__FILE__), './input.small')
    input = File.open(file_name).readlines
    solver = Solver.new(input)
    assert_equal(152, solver.solve)
  end

  def test_part1_large
   file_name = File.join(File.dirname(__FILE__), './input')
   input = File.open(file_name).readlines
   solver = Solver.new(input)
   assert_equal(152479825094094, solver.solve)
  end

  def test_part2_small
   file_name = File.join(File.dirname(__FILE__), './input.small')
   input = File.open(file_name).readlines
   solver = Solver.new(input)
   assert_equal(301, solver.solve2)
  end

  def test_part2_large
   file_name = File.join(File.dirname(__FILE__), './input')
   input = File.open(file_name).readlines
   solver = Solver.new(input)
   assert_equal(3360561285172, solver.solve2)
  end
end
