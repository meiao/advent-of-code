require 'minitest/autorun'
require_relative '2024-16'

# Tests for 2024 day 16
class Test2024_16 < Minitest::Test
  def test_part1_small
    file_name = File.join(File.dirname(__FILE__), './input.small')
    input = File.open(file_name).readlines(&:strip)
    solver = Solver.new(input)
    assert_equal(7_036, solver.solve)
  end

  def test_part1_large
    file_name = File.join(File.dirname(__FILE__), './input')
    input = File.open(file_name).readlines(&:strip)
    solver = Solver.new(input)
    assert_equal(102_504, solver.solve)
  end

  def test_part2_small
    file_name = File.join(File.dirname(__FILE__), './input.small')
    input = File.open(file_name).readlines.map(&:strip)
    solver = Solver.new(input)
    assert_equal(45, solver.solve2(7036))
  end

  def test_part2_large
    file_name = File.join(File.dirname(__FILE__), './input')
    input = File.open(file_name).readlines(&:strip)
    solver = Solver.new(input)
    assert_equal(535, solver.solve2(102_504))
  end
end
