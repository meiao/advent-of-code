require 'minitest/autorun'
require_relative '2025-01'

# Tests for 2025 day 01
class Test2025_01 < Minitest::Test
  def test_rot
    dial = Dial.new
    assert_equal(50, dial.num)
    dial.rotate('R1')
    assert_equal(51, dial.num)
    dial.rotate('L52')
    assert_equal(99, dial.num)
  end

  def test_passed_0
    solver = Solver.new
    assert_equal(1, solver.passed_0(1, 'L1'))
    assert_equal(2, solver.passed_0(1, 'L101'))
    assert_equal(0, solver.passed_0(82, 'L68'))
    assert_equal(1, solver.passed_0(99, 'R1'))
    assert_equal(2, solver.passed_0(99, 'R101'))
    assert_equal(3, solver.passed_0(99, 'R203'))
  end

  def test_part1_small
    file_name = File.join(File.dirname(__FILE__), './input')
    input = File.open(file_name).readlines.map(&:strip)
    solver = Solver.new
    assert_equal(3, solver.solve(input))
  end

  def test_part2
    file_name = File.join(File.dirname(__FILE__), './input')
    input = File.open(file_name).readlines.map(&:strip)
    solver = Solver.new
    assert_equal(6, solver.solve2(input))
  end
end
