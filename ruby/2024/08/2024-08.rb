#!/usr/local/bin/ruby

# This program answers Advent of Code 2024 day 08
#
# Author::    Andre Onuki
# License::   GPL3

require_relative('../../util/grid')

class Solver
  def solve(input)
    grid = Grid.new(input)
    limits = grid.limits
    antennas = calc_antennas(grid)
    antennas.values.map { |positions| calc_antinodes(positions) }
            .flatten(1) # this combines the arrays created by each signal type
            .filter { |pos| valid?(pos, limits) }
            .uniq
            .count
  end

  # this actually returns a map of antennas by signal type
  def calc_antennas(grid)
    max_x, max_y = grid.limits
    antennas = Hash.new { |map, char| map[char] = [] }
    (0..max_y).each do |y|
      (0..max_x).each do |x|
        pos = [x, y]
        char = grid[pos]
        antennas[char] << pos unless char == '.'
      end
    end
    antennas
  end

  def calc_antinodes(positions)
    positions.combination(2)
             .map do |p1, p2|
      x = p1[0] - p2[0]
      y = p1[1] - p2[1]
      [[p1[0] + x, p1[1] + y],
       [p2[0] - x, p2[1] - y]]
    end
      .flatten(1) # this combines the arrays created by each combination
  end

  def valid?(pos, limits)
    return false if pos[0] < 0 || pos[1] < 0 || pos[0] > limits[0] || pos[1] > limits[1]

    true
  end

  def solve2(input)
    grid = Grid.new(input)
    limits = grid.limits
    antennas = calc_antennas(grid)
    antennas.values.map { |positions| calc_antinodes2(positions, limits) }
            .flatten(1) # this combines the arrays created by each signal type
            .uniq
            .count
  end

  def calc_antinodes2(positions, limits)
    positions.combination(2)
             .map do |p1, p2|
      x = p1[0] - p2[0]
      y = p1[1] - p2[1]
      calc_line(p1, [x, y], limits)
    end
      .flatten(1) # this combines the arrays created by each combination
  end

  def calc_line(p, dir, limits)
    line = [p]
    i = 1
    loop do
      # this loop's performance could be improved by calculating only
      # the positives then the negatives
      new_pos = [
        [p[0] + dir[0] * i, p[1] + dir[1] * i],
        [p[0] - dir[0] * i, p[1] - dir[1] * i]
      ].filter { |pos| valid?(pos, limits) }
      break if new_pos.empty?

      line.concat(new_pos)
      i += 1
    end
    line
  end
end
