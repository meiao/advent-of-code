require 'minitest/autorun'
require_relative '2022-17'

# Tests for 2022 day 17
class Test2022_17 < Minitest::Test

  # def test_jet_stream
  #   file_name = File.join(File.dirname(__FILE__), './input.small')
  #   input = File.open(file_name).readlines[0].strip
  #   jet_stream = JetStream.new(input)
  #   actual = ''
  #   (input.size * 2).times do
  #     actual << jet_stream.get_next
  #   end
  #   assert_equal(input + input, actual)
  # end

 #  def test_part1_small
 #    file_name = File.join(File.dirname(__FILE__), './input.small')
 #    input = File.open(file_name).readlines
 #    solver = Solver.new(input[0].strip)
 #    assert_equal(3068, solver.solve(2022))
 #  end
 #
  def test_part1_large
   file_name = File.join(File.dirname(__FILE__), './input')
   input = File.open(file_name).readlines
   solver = Solver.new(input[0].strip)
   assert_equal(3059, solver.solve(2022))
  end
 #
 #  def test_part2_small
 #   file_name = File.join(File.dirname(__FILE__), './input.small')
 #   input = File.open(file_name).readlines
 #   solver = Solver.new(input[0].strip)
 #   assert_equal(1, solver.solve2)
 # end

  # def test_part2_large
  #  file_name = File.join(File.dirname(__FILE__), './input')
  #  input = File.open(file_name).readlines
  #  solver = Solver.new(input[0].strip)
  #  assert_equal(1, solver.solve(1000000000000))
  # end
end
