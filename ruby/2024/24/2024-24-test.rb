require 'minitest/autorun'
require_relative '2024-24'

# Tests for 2024 day 24
class Test2024_24 < Minitest::Test
  def test_part1_small
    wires_file = File.join(File.dirname(__FILE__), './small.wires')
    wires = File.open(wires_file).readlines.map(&:strip)
    gates_file = File.join(File.dirname(__FILE__), './small.gates')
    gates = File.open(gates_file).readlines.map(&:strip)
    solver = Solver.new
    assert_equal(4, solver.solve(wires, gates))
  end

  # The following test was written to find the solution to part 2.
  # My input is not being committed, so it won't run.
  # def test_part2_large
  #   gates_file = File.join(File.dirname(__FILE__), './large.gates')
  #   gates = File.open(gates_file).readlines.map(&:strip)
  #   solver = Solver.new
  #   assert_equal('!!!', solver.solve2(gates))
  # end
end
