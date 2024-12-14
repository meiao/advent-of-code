require 'minitest/autorun'
require_relative '2024-14'

# Tests for 2024 day 14
class Test2024_14 < Minitest::Test
  def test_part1_small
    file_name = File.join(File.dirname(__FILE__), './input.small')
    input = File.open(file_name).readlines
    solver = Solver.new
    assert_equal(12, solver.solve(input, [11, 7]))
  end

  def test_part1_large
    file_name = File.join(File.dirname(__FILE__), './input')
    input = File.open(file_name).readlines
    solver = Solver.new
    assert_equal(216_027_840, solver.solve(input, [101, 103]))
  end

  # to test this, after moving, check for a big rectangle
  # ############################### (this wide)
  # but without knowing this, this would be super hard to test
  # because there are a bunch of robots that are not part of
  # the picture
  #
  # def test_part2_large
  #  file_name = File.join(File.dirname(__FILE__), './input')
  #  input = File.open(file_name).readlines
  #  solver = Solver.new
  #  assert_equal(6876, solver.solve2(input, [101, 103]))
  # end
end
