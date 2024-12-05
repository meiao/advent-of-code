#!/usr/local/bin/ruby
require_relative '../../util/grid'

# This program answers Advent of Code 2024 day 04
#
# Author::    Andre Onuki
# License::   GPL3

class Solver
  def solve(input)
    grid = Grid.new(input)
    finder = Finder.new(grid)
    finder.find8way(%w[X M A S]).size
  end

  def solve2(input)
    grid = Grid.new(input)
    limits = grid.limits
    x_mas = 0
    (1..limits[1]).each do |y|
      (1..limits[0]).each do |x|
        next if grid[[x, y]] != 'A'

        diagonal1 = [[1, 1], [-1, -1]].map { |dir| grid[[x + dir[0], y + dir[1]]] }
        next unless diagonal1.include?('M') && diagonal1.include?('S')

        diagonal2 = [[1, -1], [-1, 1]].map { |dir| grid[[x + dir[0], y + dir[1]]] }
        next unless diagonal2.include?('M') && diagonal2.include?('S')

        x_mas += 1
      end
    end
    x_mas
  end
end
