require 'minitest/autorun'
require_relative '2024-17'

# Tests for 2024 day 17
class Test2024_17 < Minitest::Test
  def test_part1_small
    solver = Solver.new
    assert_equal('4,6,3,5,6,3,5,2,1,0', solver.solve('0,1,5,4,3,0', { a: 729, b: 0, c: 0 }))
  end

  def test_part1_large
    solver = Solver.new
    assert_equal('7,3,1,3,6,3,6,0,2', solver.solve('2,4,1,5,7,5,1,6,0,3,4,0,5,5,3,0', { a: 24_847_151, b: 0, c: 0 }))
  end

  # def test_part2_small
  #  solver = Solver.new
  #  assert_equal(117440, solver.solve2("0,3,5,4,3,0"))
  # end

  def test_part2_large
    solver = Solver.new
    assert_equal(105_843_716_614_554, solver.solve2('2,4,1,5,7,5,1,6,0,3,4,0,5,5,3,0'))
  end
end
