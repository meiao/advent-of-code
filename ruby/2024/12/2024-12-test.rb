require 'minitest/autorun'
require_relative '2024-12'

# Tests for 2024 day 12
class Test2024_12 < Minitest::Test
  def test_part1_small
    file_name = File.join(File.dirname(__FILE__), './input.small')
    input = File.open(file_name).readlines.map(&:rstrip)
    solver = Solver.new
    assert_equal(140, solver.solve(input))
  end

  def test_part1_medium
    file_name = File.join(File.dirname(__FILE__), './input.medium')
    input = File.open(file_name).readlines.map(&:rstrip)
    solver = Solver.new
    assert_equal(1930, solver.solve(input))
  end

  def test_part1_large
    file_name = File.join(File.dirname(__FILE__), './input')
    input = File.open(file_name).readlines.map(&:rstrip)
    solver = Solver.new
    assert_equal(1_381_056, solver.solve(input))
  end

  def test_part2_small
    file_name = File.join(File.dirname(__FILE__), './input.small')
    input = File.open(file_name).readlines.map(&:rstrip)
    solver = Solver.new
    assert_equal(80, solver.solve2(input))
  end

  def test_part2_medium
    file_name = File.join(File.dirname(__FILE__), './input.medium')
    input = File.open(file_name).readlines.map(&:rstrip)
    solver = Solver.new
    assert_equal(1206, solver.solve2(input))
  end

  def test_part2_large
    file_name = File.join(File.dirname(__FILE__), './input')
    input = File.open(file_name).readlines.map(&:rstrip)
    solver = Solver.new
    assert_equal(834_828, solver.solve2(input))
  end
end
