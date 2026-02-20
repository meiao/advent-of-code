require 'minitest/autorun'
require_relative '2025-11'

# Tests for 2025 day 11
class Test2025_11 < Minitest::Test
  def test_part1
    file_name = File.join(File.dirname(__FILE__), './input1')
    input = File.open(file_name).readlines.map(&:strip)
    solver = Solver.new(input)
    assert_equal(5, solver.solve('you', 'out'))
  end

  def test_part2
    file_name = File.join(File.dirname(__FILE__), './input2')
    input = File.open(file_name).readlines.map(&:strip)
    solver = Solver.new(input)
    svr_dac = solver.solve('svr', 'dac')
    dac_fft = solver.solve('dac', 'fft')
    fft_out = solver.solve('fft', 'out')
    svr_fft = solver.solve('svr', 'fft')
    fft_dac = solver.solve('fft', 'dac')
    dac_out = solver.solve('dac', 'out')

    assert_equal(2, svr_dac * dac_fft * fft_out + svr_fft * fft_dac * dac_out)
  end
end
