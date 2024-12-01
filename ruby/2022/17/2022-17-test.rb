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

  # def test_part1_small
  #   file_name = File.join(File.dirname(__FILE__), './input.small')
  #   input = File.open(file_name).readlines
  #   solver = Solver.new(input[0].strip)
  #   assert_equal(3068, solver.solve(2022))
  # end

  def test_part1_large
    file_name = File.join(File.dirname(__FILE__), './input')
    input = File.open(file_name).readlines
    solver = Solver.new(input[0].strip)
    assert_equal(3059, solver.solve(2022))
  end

  def test_part1_large_10000
    file_name = File.join(File.dirname(__FILE__), './input')
    input = File.open(file_name).readlines
    solver = Solver.new(input[0].strip)
    assert_equal(15_037, solver.solve(10_000))
  end

  # def test_part1_large_10000
  #  file_name = File.join(File.dirname(__FILE__), './input')
  #  input = File.open(file_name).readlines
  #  solver = Solver.new(input[0].strip)
  #  assert_equal(15037, solver.solve(10000))
  # end
  #
  #  def test_part2_small
  #   file_name = File.join(File.dirname(__FILE__), './input.small')
  #   input = File.open(file_name).readlines
  #   solver = Solver.new(input[0].strip)
  #   assert_equal(1, solver.solve2)
  # end

  def test_part2_large
    file_name = File.join(File.dirname(__FILE__), './input')
    input = File.open(file_name).readlines
    solver = Solver.new(input[0].strip)
    assert_equal(1_500_874_635_587, solver.solve(1_000_000_000_000))
  end
end
