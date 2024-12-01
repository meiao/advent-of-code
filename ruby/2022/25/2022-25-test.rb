require 'minitest/autorun'
require_relative '2022-25'

# Tests for 2022 day 25
class Test2022_25 < Minitest::Test
  def test_dec_to_snafu
    tests = {
      1 => '1',
      2 => '2',
      3 => '1=',
      4 => '1-',
      5 => '10',
      6 => '11',
      7 => '12',
      8 => '2=',
      9 => '2-',
      10 => '20',
      15 => '1=0',
      20 => '1-0',
      2022 => '1=11-2',
      12_345 => '1-0---0',
      314_159_265 => '1121-1110-1=0'
    }
    tests.each do |dec, snafu|
      assert_equal(snafu, Snafu.from_dec(dec))
    end
  end

  def test_snafu_to_dec
    tests = {
      1 => '1',
      2 => '2',
      3 => '1=',
      4 => '1-',
      5 => '10',
      6 => '11',
      7 => '12',
      8 => '2=',
      9 => '2-',
      10 => '20',
      15 => '1=0',
      20 => '1-0',
      2022 => '1=11-2',
      12_345 => '1-0---0',
      314_159_265 => '1121-1110-1=0'
    }
    tests.each do |dec, snafu|
      assert_equal(dec, Snafu.to_dec(snafu))
    end
  end

  def test_part1_small
    file_name = File.join(File.dirname(__FILE__), './input.small')
    input = File.open(file_name).readlines
    solver = Solver.new
    assert_equal('2=-1=0', solver.solve(input))
  end

  def test_part1_large
    file_name = File.join(File.dirname(__FILE__), './input')
    input = File.open(file_name).readlines
    solver = Solver.new
    assert_equal('2=--=0000-1-0-=1=0=2', solver.solve(input))
  end
end
