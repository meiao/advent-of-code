require 'minitest/autorun'
require_relative '2022-05'

# Tests for 2022 day 05
class Test2022_05 < Minitest::Test
  def test_part1_small
    solver = Solver.new
    file_name = File.join(File.dirname(__FILE__), './input.small')
    input = File.open(file_name).readlines
    assert_equal('CMZ', solver.solve(input))
  end

  def test_part1_large
    solver = Solver.new
    file_name = File.join(File.dirname(__FILE__), './input')
    input = File.open(file_name).readlines
    assert_equal('FWSHSPJWM', solver.solve(input))
  end

  def test_part2_small
    solver = Solver2.new
    file_name = File.join(File.dirname(__FILE__), './input.small')
    input = File.open(file_name).readlines
    assert_equal('MCD', solver.solve(input))
  end

  def test_part2_large
    solver = Solver2.new
    file_name = File.join(File.dirname(__FILE__), './input')
    input = File.open(file_name).readlines
    assert_equal('PWPWHGFZS', solver.solve(input))
  end
end
