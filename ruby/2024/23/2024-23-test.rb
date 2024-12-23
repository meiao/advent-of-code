require 'minitest/autorun'
require_relative '2024-23'

# Tests for 2024 day 23
class Test2024_23 < Minitest::Test
  def test_part1_small
    file_name = File.join(File.dirname(__FILE__), './input.small')
    input = File.open(file_name).readlines.map(&:strip)
    solver = Solver.new
    assert_equal(7, solver.solve(input))
  end

  def test_part1_large
    file_name = File.join(File.dirname(__FILE__), './input')
    input = File.open(file_name).readlines.map(&:strip)
    solver = Solver.new
    assert_equal(1_173, solver.solve(input))
  end

  def test_part2_small
    file_name = File.join(File.dirname(__FILE__), './input.small')
    input = File.open(file_name).readlines.map(&:strip)
    solver = Solver.new
    assert_equal('co,de,ka,ta', solver.solve2(input))
  end

  def test_part2_large
    file_name = File.join(File.dirname(__FILE__), './input')
    input = File.open(file_name).readlines.map(&:strip)
    solver = Solver.new
    assert_equal('cm,de,ez,gv,hg,iy,or,pw,qu,rs,sn,uc,wq', solver.solve2(input))
  end
end
