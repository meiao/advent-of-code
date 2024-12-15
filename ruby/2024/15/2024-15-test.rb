require 'minitest/autorun'
require_relative '2024-15'

# Tests for 2024 day 15
class Test2024_15 < Minitest::Test
  def test_part1_smaller
    file_name = File.join(File.dirname(__FILE__), './input.smaller')
    input = File.open(file_name).readlines.map(&:strip).join
    map_name = File.join(File.dirname(__FILE__), './map.smaller')
    map = File.open(map_name).readlines.map(&:strip)
    solver = Solver.new
    assert_equal(2028, solver.solve(map, input))
  end

  def test_part1_small
    file_name = File.join(File.dirname(__FILE__), './input.small')
    input = File.open(file_name).readlines.map(&:strip).join
    map_name = File.join(File.dirname(__FILE__), './map.small')
    map = File.open(map_name).readlines.map(&:strip)
    solver = Solver.new
    assert_equal(10_092, solver.solve(map, input))
  end

  def test_part1_large
    file_name = File.join(File.dirname(__FILE__), './input')
    input = File.open(file_name).readlines.map(&:strip).join
    map_name = File.join(File.dirname(__FILE__), './map')
    map = File.open(map_name).readlines.map(&:strip)
    solver = Solver.new
    assert_equal(1_475_249, solver.solve(map, input))
  end

  def test_part2_small
    file_name = File.join(File.dirname(__FILE__), './input.small')
    input = File.open(file_name).readlines.map(&:strip).join
    map_name = File.join(File.dirname(__FILE__), './map.small')
    map = File.open(map_name).readlines.map(&:strip)
    solver = Solver.new
    assert_equal(9021, solver.solve2(map, input))
  end

  def test_part2_large
    file_name = File.join(File.dirname(__FILE__), './input')
    input = File.open(file_name).readlines.map(&:strip).join
    map_name = File.join(File.dirname(__FILE__), './map')
    map = File.open(map_name).readlines.map(&:strip)
    solver = Solver.new
    assert_equal(1_509_724, solver.solve2(map, input))
  end
end
