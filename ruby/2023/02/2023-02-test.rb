require 'minitest/autorun'
require_relative '2023-02'

# Tests for 2023 day 02
class Test2023_02 < Minitest::Test
  # def test_part1_small
  #   file_name = File.join(File.dirname(__FILE__), './input.small')
  #   input = File.open(file_name).readlines
  #   solver = Solver.new
  #   assert_equal(8, solver.solve(input))
  # end
  #
  # def test_part1_large
  #  file_name = File.join(File.dirname(__FILE__), './input')
  #  input = File.open(file_name).readlines
  #  solver = Solver.new
  #  assert_equal(2449, solver.solve(input))
  # end

  def test_part2_small
    file_name = File.join(File.dirname(__FILE__), './input.small')
    input = File.open(file_name).readlines
    solver = Solver.new
    assert_equal(2286, solver.solve2(input))
  end

  def test_part2_large
    file_name = File.join(File.dirname(__FILE__), './input')
    input = File.open(file_name).readlines
    solver = Solver.new
    assert_equal(63_981, solver.solve2(input))
  end
end
