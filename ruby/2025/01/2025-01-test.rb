require 'minitest/autorun'
require_relative '2025-01'

# Tests for 2025 day 01
class Test2025_01 < Minitest::Test
  def test_rot
    dial = Dial.new
    assert_equal(50, dial.num)

    dial.rotate('R1')
    assert_equal(51, dial.num)
    assert_equal(0, dial.passed_zero)

    dial.rotate('L52')
    assert_equal(99, dial.num)
    assert_equal(1, dial.passed_zero)

    dial.rotate('L101')
    assert_equal(98, dial.num)
    assert_equal(2, dial.passed_zero)

    dial.rotate('L200')
    assert_equal(98, dial.num)
    assert_equal(4, dial.passed_zero)
    assert_equal(0, dial.at_zero)

    dial.rotate('R2')
    assert_equal(0, dial.num)
    assert_equal(5, dial.passed_zero)
    assert_equal(1, dial.at_zero)

    dial.rotate('L50')
    assert_equal(50, dial.num)
    assert_equal(5, dial.passed_zero)
    assert_equal(1, dial.at_zero)

    dial.rotate('L50')
    assert_equal(0, dial.num)
    assert_equal(6, dial.passed_zero)
    assert_equal(2, dial.at_zero)
  end

  def test_parts
    file_name = File.join(File.dirname(__FILE__), './input')
    input = File.open(file_name).readlines.map(&:strip)
    solver = Solver.new
    dial = solver.solve(input)
    # part 1
    assert_equal(3, dial.at_zero)

    # part 2
    assert_equal(6, dial.passed_zero)
  end
end
