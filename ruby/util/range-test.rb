require 'minitest/autorun'
require_relative 'range'

class TestRange < Minitest::Test
  def test_ranges
    ranges = Ranges.new
    assert(!ranges.in?(1))

    ranges.add([1, 2])
    assert(ranges.in?(1))

    ranges.add([4, 5])
    assert(ranges.in?(1))
    assert(!ranges.in?(3))
    assert(ranges.in?(5))

    ranges.add([4, 10])
    assert(ranges.in?(1))
    assert(!ranges.in?(3))
    assert(ranges.in?(10))

    ranges.add([0, 4])
    assert(ranges.in?(1))
    assert(ranges.in?(3))
    assert(ranges.in?(10))
  end
end
