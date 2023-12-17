require 'minitest/autorun'
require_relative '2023-13'

# Tests for 2023 day 13
class Test2023_13 < Minitest::Test
  def test_part1_small
    file_name = File.join(File.dirname(__FILE__), './input.small')
    input = File.open(file_name).readlines.join.split("\n\n").map{|map| map.split("\n")}
    solver = Solver.new
    assert_equal(1, solver.solve(input))
  end

  def test_part1_large
   file_name = File.join(File.dirname(__FILE__), './input')
   input = File.open(file_name).readlines.join.split("\n\n").map{|map| map.split("\n")}
   solver = Solver.new
   assert_equal(1, solver.solve(input))
  end

  def test_part2_small
   file_name = File.join(File.dirname(__FILE__), './input.small')
   input = File.open(file_name).readlines.join.split("\n\n").map{|map| map.split("\n")}
   solver = Solver2.new
   assert_equal(400, solver.solve(input))
  end

  def test_part2_large
   file_name = File.join(File.dirname(__FILE__), './input')
   input = File.open(file_name).readlines.join.split("\n\n").map{|map| map.split("\n")}
   solver = Solver2.new
   assert_equal(30842, solver.solve(input))
  end
end
