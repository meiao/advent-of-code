#!/usr/local/bin/ruby

# This program answers Advent of Code 2024 day 06
#
# Author::    Andre Onuki
# License::   GPL3

require_relative('../../util/grid')
class Solver
  def initialize(input)
    @grid = Grid.new(input)
    @start_point = Finder.new(@grid).find_single_char('^')[0][0]
  end

  def solve
    visited_positions.count
  end

  def visited_positions
    dir = Direction.new
    position = @start_point
    positions = Hash.new(false)
    positions[position] = true
    while true
      next_pos = [position[0] + dir[0], position[1] + dir[1]]
      while @grid[next_pos] == '#'
        dir.turn_right
        next_pos = [position[0] + dir[0], position[1] + dir[1]]
      end
      next_char = @grid[next_pos]
      break unless ['.', '^'].include?(next_char)

      position = next_pos
      positions[position] = true
    end
    positions
  end

  def print_grid(positions)
    limits = @grid.limits
    (0..limits[1]).each do |y|
      (0..limits[0]).each do |x|
        pos = [x, y]
        if positions[pos]
          print 'X'
        elsif @grid[pos] == '#'
          print '#'
        else
          print '.'
        end
      end
      puts
    end
    puts
  end

  def solve2
    visited_positions = visited_positions()
    visited_positions.delete(@start_point)
    visited_positions.filter do |new_wall|
      loop?(new_wall)
    end.count
  end

  # This is roughly the same navigation code as the first part
  # But this stores position with the direction facing, because
  # if the same positions with the same direction is ever reached,
  # then it is a loop.
  # Also, it adds a check for the new wall
  def loop?(new_wall)
    dir = Direction.new
    position = @start_point
    positions = Hash.new(false)
    positions[[position, dir.simple]] = true
    while true
      next_pos = [position[0] + dir[0], position[1] + dir[1]]
      while @grid[next_pos] == '#' || next_pos == new_wall
        dir.turn_right
        next_pos = [position[0] + dir[0], position[1] + dir[1]]
      end
      return false if @grid[next_pos].nil?

      position = next_pos
      vec = [position, dir.simple]
      return true if positions[vec]

      positions[vec] = true
    end
    true
  end
end

class Direction
  def initialize
    @cur = [0, -1]
  end

  def turn_right
    @cur = case @cur
           when [0, -1]
             [1, 0]
           when [1, 0]
             [0, 1]
           when [0, 1]
             [-1, 0]
           else
             [0, -1]
           end
  end

  def [](index)
    @cur[index]
  end

  def simple
    [@cur[0], @cur[1]]
  end
end
