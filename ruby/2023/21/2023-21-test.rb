require 'minitest/autorun'
require_relative '2023-21'

# Tests for 2023 day 21
class Test2023_21 < Minitest::Test
  def test_part1_small
    file_name = File.join(File.dirname(__FILE__), './input.small')
    input = File.open(file_name).readlines
    solver = Solver.new(input)
    assert_equal(16, solver.solve(6))
  end

  def test_part1_large
    file_name = File.join(File.dirname(__FILE__), './input')
    input = File.open(file_name).readlines
    solver = Solver.new(input)
    assert_equal(3562, solver.solve(64))
  end

  # def test_part2_small
  #  file_name = File.join(File.dirname(__FILE__), './input.small')
  #  input = File.open(file_name).readlines
  #  solver = Solver.new(input)
  #  # assert_equal(50, solver.solve2(10))
  #  # assert_equal(1594, solver.solve2(50))
  #  # assert_equal(6536, solver.solve2(100))
  #  # assert_equal(167004, solver.solve2(500))
  #  # assert_equal(668697, solver.solve2(1000))
  #  # assert_equal(16733044, solver.solve2(5000))
  # end

  def test_part2_large
    file_name = File.join(File.dirname(__FILE__), './input')
    input = File.open(file_name).readlines
    solver = Solver.new(input)
    assert_equal(592_723_929_260_582, solver.solve2(26_501_365))
  end
end
