require 'minitest/autorun'
require_relative '2024-22'

# Tests for 2024 day 22
class Test2024_22 < Minitest::Test
  def test_evolution
    solver = Solver.new
    assert_equal(15_887_950, solver.evolve_once(123))
    assert_equal(16_495_136, solver.evolve_once(15_887_950))
    assert_equal(527_345, solver.evolve_once(16_495_136))
    assert_equal(704_524, solver.evolve_once(527_345))
    assert_equal(1_553_684, solver.evolve_once(704_524))
    assert_equal(12_683_156, solver.evolve_once(1_553_684))
    assert_equal(11_100_544, solver.evolve_once(12_683_156))
    assert_equal(12_249_484, solver.evolve_once(11_100_544))
    assert_equal(7_753_432, solver.evolve_once(12_249_484))
    assert_equal(5_908_254, solver.evolve_once(7_753_432))
    assert_equal(8_685_429, solver.evolve(1, 2000))
    assert_equal(4_700_978, solver.evolve(10, 2000))
    assert_equal(15_273_692, solver.evolve(100, 2000))
    assert_equal(8_667_524, solver.evolve(2024, 2000))
  end

  def test_part1_small
    file_name = File.join(File.dirname(__FILE__), './input.small')
    input = File.open(file_name).readlines.map(&:strip)
    solver = Solver.new
    assert_equal(37_327_623, solver.solve(input))
  end

  def test_part1_large
    file_name = File.join(File.dirname(__FILE__), './input')
    input = File.open(file_name).readlines.map(&:strip)
    solver = Solver.new
    assert_equal(18_525_593_556, solver.solve(input))
  end

  def test_part2_small
    file_name = File.join(File.dirname(__FILE__), './input2.small')
    input = File.open(file_name).readlines.map(&:strip)
    solver = Solver.new
    assert_equal(23, solver.solve2(input))
  end

  def test_part2_large
    file_name = File.join(File.dirname(__FILE__), './input')
    input = File.open(file_name).readlines.map(&:strip)
    solver = Solver.new
    assert_equal(2089, solver.solve2(input))
  end
end
