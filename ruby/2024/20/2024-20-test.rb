require 'minitest/autorun'
require_relative '2024-20'

# Tests for 2024 day 20
class Test2024_20 < Minitest::Test
  def test_part1_small
    file_name = File.join(File.dirname(__FILE__), './input.small')
    input = File.open(file_name).readlines.map(&:strip)
    solver = Solver.new
    assert_equal(10, solver.solve(input, 2, 10))
  end

  def test_part1_large
    file_name = File.join(File.dirname(__FILE__), './input')
    input = File.open(file_name).readlines.map(&:strip)
    solver = Solver.new
    assert_equal(1395, solver.solve(input, 2, 100))
  end

  def test_part2_small
    file_name = File.join(File.dirname(__FILE__), './input.small')
    input = File.open(file_name).readlines.map(&:strip)
    solver = Solver.new
    assert_equal(285, solver.solve(input, 20, 50))
  end

  def test_part2_large
    file_name = File.join(File.dirname(__FILE__), './input')
    input = File.open(file_name).readlines.map(&:strip)
    solver = Solver.new
    assert_equal(993_178, solver.solve(input, 20, 100))
  end
end
