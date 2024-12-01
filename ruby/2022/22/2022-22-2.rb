#!/usr/local/bin/ruby

# This program answers Advent of Code 2022 day 22
#
# This version ran in
#
# Author::    Andre Onuki
# License::   GPL3

require_relative '2022-22'

class Solver2 < Solver
  def solve(input)
    map = create_map(input[0..-3])
    me = Me.new(map)
    cmds = input[-1].strip.chars
    until cmds.empty?
      num = ''
      num << cmds.shift while !cmds[0].nil? && cmds[0] != 'R' && cmds[0] != 'L'
      me.move(num.to_i)
      dir = cmds.shift
      me.turn(dir) unless dir.nil?
    end
    coord = me.cur_cell.point
    1000 * (coord[1] + 1) + 4 * (coord[0] + 1) + me.cur_dir.value
  end

  def create_map(lines)
    map = {}
    lines.each_with_index do |line, y|
      line.rstrip.chars.each_with_index do |c, x|
        next if c == ' '

        map[[x, y]] = (c == '.' ? Cell.new([x, y], map) : Wall.instance)
      end
    end
    create_special_moves(map)
    map
  end

  def create_special_moves(map)
    50.times do |i|
      map[[149, i]].set_next_cell(:R, map[[99, 149 - i]], :L)
      map[[99, 50 + i]].set_next_cell(:R, map[[100 + i, 49]], :U)
      map[[99, 100 + i]].set_next_cell(:R, map[[149, 49 - i]], :L)
      map[[49, 150 + i]].set_next_cell(:R, map[[50 + i, 149]], :U)
      map[[50, i]].set_next_cell(:L, map[[0, 149 - i]], :R)
      map[[50, 50 + i]].set_next_cell(:L, map[[i, 100]], :D)
      map[[0, 100 + i]].set_next_cell(:L, map[[50, 49 - i]], :R)
      map[[0, 150 + i]].set_next_cell(:L, map[[50 + i, 0]], :D)
      map[[i, 199]].set_next_cell(:D, map[[100 + i, 0]], :D)
      map[[50 + i, 149]].set_next_cell(:D, map[[49, 150 + i]], :L)
      map[[100 + i, 49]].set_next_cell(:D, map[[99, 50 + i]], :L)
      map[[i, 100]].set_next_cell(:U, map[[50, 50 + i]], :R)
      map[[50 + i, 0]].set_next_cell(:U, map[[0, 150 + i]], :R)
      map[[100 + i, 0]].set_next_cell(:U, map[[i, 199]], :U)
    end
  end
end
