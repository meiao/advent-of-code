require 'minitest/autorun'
require_relative '2022-22'
require_relative '2022-22-2'

# Tests for 2022 day 22
class Test2022_22 < Minitest::Test
  def test_part1_small
    file_name = File.join(File.dirname(__FILE__), './input.small')
    input = File.open(file_name).readlines
    solver = Solver.new
    assert_equal(6032, solver.solve(input))
  end

  def test_part1_large
    file_name = File.join(File.dirname(__FILE__), './input')
    input = File.open(file_name).readlines
    solver = Solver.new
    assert_equal(103_224, solver.solve(input))
  end

  # part 2 small is currently unsolvable given the hardcoded stuff in the code
  # def test_part2_small
  #  file_name = File.join(File.dirname(__FILE__), './input.small')
  #  input = File.open(file_name).readlines
  #  solver = Solver.new
  #  assert_equal(1, solver.solve2(input))
  # end

  def test_part2_large
    file_name = File.join(File.dirname(__FILE__), './input')
    input = File.open(file_name).readlines
    solver = Solver2.new
    assert_equal(189_097, solver.solve(input))
  end
end
