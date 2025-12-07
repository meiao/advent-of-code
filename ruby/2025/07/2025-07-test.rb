require 'minitest/autorun'
require_relative '2025-07'

# Tests for 2025 day 07
class Test2025_07 < Minitest::Test
  def test_part1
    file_name = File.join(File.dirname(__FILE__), './input')
    input = File.open(file_name).readlines.map(&:strip)
    solver = Solver.new
    solution = solver.solve(input)
    # part 1
    assert_equal(21, solution[0])
    # part 2
    assert_equal(40, solution[1])
  end
end
