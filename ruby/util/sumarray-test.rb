require 'minitest/autorun'
require_relative 'sumarray'

class TestSumArray < Minitest::Test
  def test_array_size_1
    sumarray = SumArray.new(1, 1)
    assert_equal([[1]], sumarray.to_a)

    sumarray = SumArray.new(10, 1)
    assert_equal([[10]], sumarray.to_a)
  end

  def test_sum_1
    sumarray = SumArray.new(1, 10)
    array = sumarray.to_a
    assert_equal(10, array.size)
    assert_equal(10, array.flatten.sum)
    tally = array.flatten.tally
    assert_equal(90, tally[0])
    assert_equal(10, tally[1])
    assert_equal(2, tally.size)
  end

  def test_size_2
    sumarray = SumArray.new(4, 2)
    array = sumarray.to_a
    assert_equal(5, array.size)
    [[4, 0], [3, 1], [2, 2], [1, 3], [0, 4]].each do |expected|
      assert(array.include?(expected))
    end
  end

  def test_size_3
    sumarray = SumArray.new(2, 3)
    array = sumarray.to_a
    assert_equal(6, array.size)
    [[0, 0, 2], [0, 1, 1], [0, 2, 0], [1, 0, 1], [1, 1, 0], [2, 0, 0]].each do |expected|
      assert(array.include?(expected))
    end
  end
end
