#!/usr/local/bin/ruby

# This program answers Advent of Code 2023 day 11
#
# Author::    Andre Onuki
# License::   GPL3
class Solver
  def solve(input)
    do_solve(input, 2)
  end

  def do_solve(input, base_multiplier)
    multiplier = base_multiplier - 1
    galaxies = get_galaxies(input)
    double_lines = get_double_lines(galaxies, input.size)
    double_columns = get_double_columns(galaxies, input[0].strip.size)
    sum = 0
    (0..(galaxies.size - 2)).each do |i|
      g_i = galaxies[i]
      ((i + 1)..(galaxies.size - 1)).each do |j|
        g_j = galaxies[j]
        sum += (g_i[0] - g_j[0]).abs + (g_i[1] - g_j[1]).abs
        lines = [g_i[1], g_j[1]].sort
        sum += double_lines.filter { |l| l > lines[0] && l < lines[1] }.size * multiplier
        cols = [g_i[0], g_j[0]].sort
        sum += double_columns.filter { |c| c > cols[0] && c < cols[1] }.size * multiplier
      end
    end
    sum
  end

  def get_galaxies(input)
    galaxies = []
    input.each_with_index do |line, y|
      line.split('').each_with_index do |char, x|
        galaxies << [x, y] if char == '#'
      end
    end
    galaxies
  end

  def get_double_lines(galaxies, size)
    lines_with_galaxies = galaxies.map { |g| g[1] }
    (0..(size - 1)).to_a.filter { |line| !lines_with_galaxies.include? line }
  end

  def get_double_columns(galaxies, size)
    columns_with_galaxies = galaxies.map { |g| g[0] }
    (0..(size - 1)).to_a.filter { |col| !columns_with_galaxies.include? col }
  end

  def solve2(input)
    do_solve(input, 1_000_000)
  end
end
