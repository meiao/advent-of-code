require 'minitest/autorun'
require_relative '2021-25'

# Tests for 2021 day 25
class Test2021_25 < Minitest::Test
  def test_part1
    file_name = File.join(File.dirname(__FILE__), './input')
    input = File.open(file_name).readlines.map(&:strip)
    solver = Solver.new
    assert_equal(58, solver.solve(input))
  end
end
