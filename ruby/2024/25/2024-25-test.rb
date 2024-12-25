require 'minitest/autorun'
require_relative '2024-25'

# Tests for 2024 day 25
class Test2024_25 < Minitest::Test
  def test_part1_small
    file_name = File.join(File.dirname(__FILE__), './input.small')
    input = File.open(file_name).readlines.join
    solver = Solver.new
    assert_equal(3, solver.solve(input))
  end

  def test_part1_large
    file_name = File.join(File.dirname(__FILE__), './input')
    input = File.open(file_name).readlines.join
    solver = Solver.new
    assert_equal(1, solver.solve(input))
  end
end
