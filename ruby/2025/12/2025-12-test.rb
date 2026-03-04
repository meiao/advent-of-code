require 'minitest/autorun'
require_relative '2025-12'

# Tests for 2025 day 12
class Test2025_12 < Minitest::Test
  def test_part1
    shapes_file_name = File.join(File.dirname(__FILE__), './input-shapes')
    shapes = File.open(shapes_file_name).readlines.map(&:strip)
    solver = Solver.new(shapes)

    regions_file_name = File.join(File.dirname(__FILE__), './input-regions')
    regions = File.open(regions_file_name).readlines.map(&:strip)
    assert_equal(1, solver.solve(regions))
  end
end
