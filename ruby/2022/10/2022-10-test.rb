require 'minitest/autorun'
require_relative '2022-10'

# Tests for 2022 day 10
class Test2022_10 < Minitest::Test
  def test_part1_small
    file_name = File.join(File.dirname(__FILE__), './input.small')
    input = File.open(file_name).readlines
    solver = Solver.new
    assert_equal(13140, solver.solve(input, [20, 60, 100, 140, 180, 220]))
  end

  def test_part1_large
    file_name = File.join(File.dirname(__FILE__), './input')
    input = File.open(file_name).readlines
    solver = Solver.new
    assert_equal(14560, solver.solve(input, [20, 60, 100, 140, 180, 220]))
  end

  def test_part2_small
    file_name = File.join(File.dirname(__FILE__), './input.small')
    input = File.open(file_name).readlines
    solver = Solver2.new
    assert_equal(
      "##..##..##..##..##..##..##..##..##..##.." +
      "###...###...###...###...###...###...###." +
      "####....####....####....####....####...." +
      "#####.....#####.....#####.....#####....." +
      "######......######......######......####" +
      "#######.......#######.......#######.....",
      solver.solve(input)
    )
  end

  def test_part2_large
    file_name = File.join(File.dirname(__FILE__), './input')
    input = File.open(file_name).readlines
    solver = Solver2.new
    assert_equal(
      "####.#..#.###..#..#.####.###..#..#.#####" +
      "#....#.#..#..#.#..#.#....#..#.#..#....#." +
      "###..##...#..#.####.###..#..#.#..#...#.." +
      "#....#.#..###..#..#.#....###..#..#..#..." +
      "#....#.#..#.#..#..#.#....#....#..#.#...." +
      "####.#..#.#..#.#..#.####.#.....##..#####",
      solver.solve(input)
    )  end
end
