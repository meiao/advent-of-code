require 'minitest/autorun'
require_relative '2022-14'

# Tests for 2022 day 14
class Test2022_14 < Minitest::Test

  def test_part1_small
    file_name = File.join(File.dirname(__FILE__), './input.small')
    input = File.open(file_name).readlines
    solver = Solver.new(input)
    assert_equal(24, solver.solve)
  end

  def test_part1_large
   file_name = File.join(File.dirname(__FILE__), './input')
   input = File.open(file_name).readlines
   solver = Solver.new(input)
   assert_equal(1298, solver.solve)
  end

  def test_part2_small
   file_name = File.join(File.dirname(__FILE__), './input.small')
   input = File.open(file_name).readlines
   solver = Solver2.new(input)
   assert_equal(93, solver.solve)
  end

  def test_part2_large
   file_name = File.join(File.dirname(__FILE__), './input')
   input = File.open(file_name).readlines
   solver = Solver2.new(input)
   assert_equal(25585, solver.solve)
  end
end
