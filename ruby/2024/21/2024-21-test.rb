require 'minitest/autorun'
require_relative '2024-21'

# Tests for 2024 day 21
class Test2024_21 < Minitest::Test
  def test_part1_small
    file_name = File.join(File.dirname(__FILE__), './input.small')
    input = File.open(file_name).readlines.map(&:strip)
    solver = Solver.new
    assert_equal(126_384, solver.solve(input, 2))
  end

  def test_part1_large
    file_name = File.join(File.dirname(__FILE__), './input')
    input = File.open(file_name).readlines.map(&:strip)
    solver = Solver.new
    assert_equal(177_814, solver.solve(input, 2))
  end

  def test_part2_large
    file_name = File.join(File.dirname(__FILE__), './input')
    input = File.open(file_name).readlines.map(&:strip)
    solver = Solver.new
    assert_equal(220_493_992_841_852, solver.solve(input, 25))
  end
end
