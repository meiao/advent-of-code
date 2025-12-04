require 'minitest/autorun'
require_relative '2025-02'

# Tests for 2025 day 02
class Test2025_02 < Minitest::Test
  def test_part1
    file_name = File.join(File.dirname(__FILE__), './input')
    input = File.open(file_name).readlines.map(&:strip)
    solver = Solver.new
    assert_equal(1227775554, solver.solve(input[0], 2))
  end

  def test_part2
   file_name = File.join(File.dirname(__FILE__), './input')
   input = File.open(file_name).readlines.map(&:strip)
   solver = Solver.new
   assert_equal(4174379265, solver.solve(input[0], 10))
  end
end
# 1575.81
