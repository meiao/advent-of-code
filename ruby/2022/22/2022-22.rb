#!/usr/local/bin/ruby

# This program answers Advent of Code 2022 day 22
#
# This version ran in
#
# Author::    Andre Onuki
# License::   GPL3

require_relative 'common'

class Solver
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
    lines.length.times do |y|
      keys_on_line = map.keys.filter { |k| k[1] == y }.sort
      left = map[keys_on_line[0]]
      right = map[keys_on_line[-1]]
      left.set_next_cell(:L, right, :L)
      right.set_next_cell(:R, left, :R)
    end
    lines[0].rstrip.length.times do |x|
      keys_on_row = map.keys.filter { |k| k[0] == x }.sort
      top = map[keys_on_row[0]]
      bottom = map[keys_on_row[-1]]
      top.set_next_cell(:U, bottom, :U)
      bottom.set_next_cell(:D, top, :D)
    end
    map
  end
end
