require 'minitest/autorun'
require_relative '2025-03'

# Tests for 2025 day 03
class Test2025_03 < Minitest::Test
  def joltage(line, battery_count)
    solver = Solver.new
    batteries = line.split('').map(&:to_i)
    solver.max_joltage(batteries, battery_count)
  end

  def test_max_joltage
    assert_equal(5, joltage('54321', 1))
    assert_equal(9, joltage('123456789', 1))
    assert_equal(42, joltage('42', 2))
    assert_equal(123, joltage('123', 3))
    assert_equal(42, joltage('1233334111112', 2))
    assert_equal(989, joltage('912384569', 3))
  end

  def test_part1
    file_name = File.join(File.dirname(__FILE__), './input')
    input = File.open(file_name).readlines.map(&:strip)
    solver = Solver.new
    assert_equal(357, solver.solve(input, 2))
  end

  def test_part2
    file_name = File.join(File.dirname(__FILE__), './input')
    input = File.open(file_name).readlines.map(&:strip)
    solver = Solver.new
    assert_equal(3_121_910_778_619, solver.solve(input, 12))
  end
end
