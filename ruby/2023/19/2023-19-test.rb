require 'minitest/autorun'
require_relative '2023-19'

# Tests for 2023 day 19
class Test2023_19 < Minitest::Test
  def test_part1_small
    file_name = File.join(File.dirname(__FILE__), './input.small')
    input = File.open(file_name).readlines
    solver = Solver.new
    workflow, parts = input.join('').split("\n\n").map{|lines| lines.split("\n")}
    assert_equal(19114, solver.solve(workflow, parts))
  end

  def test_part1_large
   file_name = File.join(File.dirname(__FILE__), './input')
   input = File.open(file_name).readlines
   solver = Solver.new
   workflow, parts = input.join('').split("\n\n").map{|lines| lines.split("\n")}
   assert_equal(1, solver.solve(workflow, parts))
  end

  #def test_part2_small
  #  file_name = File.join(File.dirname(__FILE__), './input.small')
  #  input = File.open(file_name).readlines
  #  solver = Solver.new
  #  assert_equal(1, solver.solve2(input))
  #end

  #def test_part2_large
  #  file_name = File.join(File.dirname(__FILE__), './input')
  #  input = File.open(file_name).readlines
  #  solver = Solver.new
  #  assert_equal(1, solver.solve2(input))
  #end
end
