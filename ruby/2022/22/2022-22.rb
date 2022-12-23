#!/usr/local/bin/ruby

# This program answers Advent of Code 2022 day 22
#
# This version ran in
#
# Author::    Andre Onuki
# License::   GPL3
class Solver
  def initialize

  def solve(input)
    map = create_map(input[0..-3])
    me = Me.new(map)
    cmds = input[-1].strip.chars
    until cmds.empty?
      num = ''
      while cmds[0] != nil && cmds[0] != 'R' && cmds[0] != 'L'
        num << cmds.shift
      end
      me.move(num.to_i)
      dir = cmds.shift
      me.turn(dir) if dir != nil
    end
    coord = me.cur_cell.point
    1000 * (coord[1] + 1) + 4 * (coord[0] + 1) + me.cur_dir.value
  end

  def create_map(lines)
    map = {}
    lines.each_with_index do |line, y|
      line.rstrip.chars.each_with_index do |c, x|
        next if c == ' '
        map[[x, y]] = (c == '.' ? Cell.new([x,y], map) : Wall.instance)
      end
    end
    lines.length.times do |y|
      keys_on_line = map.keys.filter{|k| k[1] == y}.sort
      left = map[keys_on_line[0]]
      right = map[keys_on_line[-1]]
      left.set_next_cell(:L, right)
      right.set_next_cell(:R, left)
    end
    lines[0].rstrip.length.times do |x|
      keys_on_row = map.keys.filter{|k| k[0] == x}.sort
      p keys_on_row
      top = map[keys_on_row[0]]
      bottom = map[keys_on_row[-1]]
      top.set_next_cell(:U, bottom)
      bottom.set_next_cell(:D, top)
    end
    map
  end
end

class Me
  attr_reader :cur_cell, :cur_dir
  def initialize(map)
    @cur_dir = Direction.map()[:R]
    @map = map
    x = 0
    while @map[[x, 0]] == nil
      x += 1
    end
    @cur_cell = @map[[x,0]]
  end

  def move(steps)
    @cur_cell = @cur_cell.move(@cur_dir, steps)
  end

  def turn(direction)
    @cur_dir = @cur_dir.turn[direction]
  end
end

class Direction
  attr_reader :name, :dir, :turn, :value
  def initialize(name, dir, value)
    @name = name
    @dir = dir
    @value = value
    @turn = {}
  end

  def self.map
    map = {
      :R => Direction.new(:R, [1,0], 0),
      :D => Direction.new(:D, [0,1], 1),
      :L => Direction.new(:L, [-1,0], 2),
      :U => Direction.new(:U, [0,-1], 4)
    }
    map[:R].turn['R'] = map[:D]
    map[:R].turn['L'] = map[:U]
    map[:D].turn['R'] = map[:L]
    map[:D].turn['L'] = map[:R]
    map[:L].turn['R'] = map[:U]
    map[:L].turn['L'] = map[:D]
    map[:U].turn['R'] = map[:R]
    map[:U].turn['L'] = map[:L]
    map
  end

end

class Cell
  attr_reader :point
  def initialize(point, map)
    @point = point
    @map = map
    @next_cell = {}
  end

  def move(direction, steps)
    cur_cell = self
    steps.times do
      next_cell = cur_cell.move_single(direction)
      return cur_cell if next_cell.is_a?(Wall)
      cur_cell = next_cell
    end
    cur_cell
  end

  def move_single(direction)
    return @next_cell[direction.name] if @next_cell[direction.name] != nil
    dir = direction.dir
    next_point = [@point[0] + dir[0], @point[1] + dir[1]]
    while @map[next_point] == nil
      next_point[0] += dir[0]
      next_point[1] += dir[1]
    end
    @next_cell[direction.name] = @map[next_point]
  end

  def set_next_cell(direction_name, cell)
    @next_cell[direction_name] = cell
  end
end

class Wall
  @@instance = Wall.new

  def self.instance
    @@instance
  end

  def set_next_cell(direction_name, cell)
    # for comaptibility with Cell
  end
end

class Solver2
  def solve
  end
end
