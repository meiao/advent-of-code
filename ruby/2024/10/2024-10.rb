#!/usr/local/bin/ruby

# This program answers Advent of Code 2024 day 10
#
# Author::    Andre Onuki
# License::   GPL3
require_relative('../../util/grid')

class Solver
  def initialize(input)
    @grid = Grid.new(input)
    finder = Finder.new(@grid)
    @trail_heads = finder.find_single_char('0').map { |vec| vec[0] }
  end

  def solve
    @trail_heads.map { |head| trail_ends(head) }
                .flatten(1)
                .count
  end

  def trail_ends(position)
    return [position] if @grid[position] == '9'

    succ = @grid[position].succ
    [[0, 1], [0, -1], [1, 0], [-1, 0]].map do |dir|
      next_pos = [position[0] + dir[0], position[1] + dir[1]]
      if @grid[next_pos] == succ
        trail_ends(next_pos)
      else
        []
      end
    end.flatten(1).uniq
  end

  def solve2
    @trail_heads.map { |head| trail_score(head) }
                .sum
  end

  def trail_score(position)
    return 1 if @grid[position] == '9'

    succ = @grid[position].succ
    [[0, 1], [0, -1], [1, 0], [-1, 0]].map do |dir|
      next_pos = [position[0] + dir[0], position[1] + dir[1]]
      if @grid[next_pos] == succ
        trail_score(next_pos)
      else
        0
      end
    end.sum
  end
end
