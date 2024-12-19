require 'minitest/autorun'
require_relative '2024-19'

# Tests for 2024 day 19
class Test2024_19 < Minitest::Test
  def test_part1_small
    file_name = File.join(File.dirname(__FILE__), './input.small')
    input = File.open(file_name).readlines.map(&:strip)
    available_towels = input.shift
    input.shift # removes empty line
    solver = Solver.new
    assert_equal(6, solver.solve(available_towels, input))
  end

  def test_part1_large
    file_name = File.join(File.dirname(__FILE__), './input')
    input = File.open(file_name).readlines.map(&:strip)
    available_towels = input.shift
    input.shift # removes empty line
    solver = Solver.new
    assert_equal(226, solver.solve(available_towels, input))
  end

  def test_part2_small
    file_name = File.join(File.dirname(__FILE__), './input.small')
    input = File.open(file_name).readlines.map(&:strip)
    available_towels = input.shift
    input.shift # removes empty line
    solver = Solver.new
    assert_equal(16, solver.solve2(available_towels, input))
  end

  def test_part2_large
    file_name = File.join(File.dirname(__FILE__), './input')
    input = File.open(file_name).readlines.map(&:strip)
    available_towels = input.shift
    input.shift # removes empty line
    solver = Solver.new
    assert_equal(601_201_576_113_503, solver.solve2(available_towels, input))
  end
end
