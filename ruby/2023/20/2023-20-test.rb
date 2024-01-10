require 'minitest/autorun'
require_relative '2023-20'

# Tests for 2023 day 20
class Test2023_20 < Minitest::Test
  def test_part1_small
    file_name = File.join(File.dirname(__FILE__), './input.small')
    input = File.open(file_name).readlines
    solver = Solver.new(input)
    assert_equal(32000000, solver.solve)
  end

  def test_part1_small2
    file_name = File.join(File.dirname(__FILE__), './input.small2')
    input = File.open(file_name).readlines
    solver = Solver.new(input)
    assert_equal(11687500, solver.solve)
  end

  def test_part1_large
   file_name = File.join(File.dirname(__FILE__), './input')
   input = File.open(file_name).readlines
   solver = Solver.new(input)
   assert_equal(684125385, solver.solve)
  end

  # Part 2 is not solvable using simulation.
  # The solution is to analyse the input and
  # see that it is a bunch of binary counters
  # that merge in a conjunction.
  # Then find out when the binary counters will
  # merge so the conjunction is satisfied.
  # The code for part 2 runs to find the number
  # of button presses for the ['lg', 'st', 'bn', 'gr']
  # conjunctions, which when all flipped, will
  # turn on the machine.

  # The first time the conjunctions flip. The response
  # is the LCM of these numbers.
  # ["lg", 3733]
  # ["gr", 3761]
  # ["bn", 4001]
  # ["st", 4021]
  def test_part2
    file_name = File.join(File.dirname(__FILE__), './input')
    input = File.open(file_name).readlines
    solver = Solver.new(input)
    assert_equal(225872806380073, solver.solve2)
  end


end
