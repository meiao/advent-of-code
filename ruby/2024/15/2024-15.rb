#!/usr/local/bin/ruby

# This program answers Advent of Code 2024 day 15
#
# Author::    Andre Onuki
# License::   GPL3
require_relative('../../util/hashgrid')

class Solver
  def solve(map, input)
    map = HashGrid.new(map, '.')
    robot = map.keys.filter { |pos| map[pos] == '@' }[0]
    input.split('').map { |dir| convert_dir(dir) }.each do |dir|
      robot = move(robot, dir, map)
    end
    map.map.filter { |_pos, value| value == 'O' }.map { |pos, _value| pos[0] + 100 * pos[1] }.sum
  end

  def convert_dir(dir)
    case dir
    when '>'
      [1, 0]
    when '<'
      [-1, 0]
    when 'v'
      [0, 1]
    else
      [0, -1]
    end
  end

  def move(robot, dir, map)
    pos = [robot[0] + dir[0], robot[1] + dir[1]]
    pos = [pos[0] + dir[0], pos[1] + dir[1]] while map[pos] == 'O'
    if map[pos] == '#'
      robot
    else
      map.delete(robot)
      map[pos] = 'O'
      robot_pos = [robot[0] + dir[0], robot[1] + dir[1]]
      map[robot_pos] = '@'
      robot_pos
    end
  end

  def solve2(map_data, input)
    limits = [2 * map_data[0].size - 1, map_data.size - 1]
    map = read_map(map_data, limits)
    robot = map.filter { |_pos, value| value == '@' }.keys[0]
    input.split('').map { |dir| convert_dir(dir) }.each do |dir|
      robot = move2(robot, dir, map)
    end
    map.filter { |_pos, value| value == '[' }.keys.map { |pos| pos[0] + 100 * pos[1] }.sum
  end

  def read_map(data, limits)
    map = Hash.new('.')
    (0..limits[1]).each do |y|
      (0..limits[0]).each do |x|
        char = data[y][x]
        case char
        when '#'
          map[[2 * x, y]] = '#'
          map[[2 * x + 1, y]] = '#'
        when '@'
          map[[2 * x, y]] = '@'
        when 'O'
          map[[2 * x, y]] = '['
          map[[2 * x + 1, y]] = ']'
        end
      end
    end
    map
  end

  def move2(robot, dir, map)
    if dir[1] == 0
      if can_move_h?(robot, dir, map)
        move_h(robot, dir, map)
        [robot[0] + dir[0], robot[1] + dir[1]]
      else
        robot
      end
    elsif can_move_v?(robot, dir, map)
      move_v(robot, dir, map)
      [robot[0] + dir[0], robot[1] + dir[1]]
    else
      robot
    end
  end

  def can_move_h?(pos, dir, map)
    loop do
      if map[pos] == '.'
        return true
      elsif map[pos] == '#'
        return false
      end

      pos = [pos[0] + dir[0], pos[1]]
    end
  end

  def move_h(pos, dir, map)
    return if map[pos] == '.'

    next_pos = [pos[0] + dir[0], pos[1]]
    move_h(next_pos, dir, map)
    map[next_pos] = map[pos]
    map.delete(pos)
  end

  def can_move_v?(pos, dir, map)
    case map[pos]
    when '.'
      true
    when '#'
      false
    when '@'
      can_move_v?([pos[0], pos[1] + dir[1]], dir, map)
    when '['
      can_move_v?([pos[0], pos[1] + dir[1]], dir, map) && can_move_v?([pos[0] + 1, pos[1] + dir[1]], dir, map)
    when ']'
      can_move_v?([pos[0] - 1, pos[1] + dir[1]], dir, map) && can_move_v?([pos[0], pos[1] + dir[1]], dir, map)
    end
  end

  def move_v(pos, dir, map, move_sibling: true)
    return if map[pos] == '.'

    next_pos = [pos[0], pos[1] + dir[1]]
    move_v(next_pos, dir, map)
    cur_char = map[pos]
    case cur_char
    when '['
      move_v([pos[0] + 1, pos[1]], dir, map, move_sibling: false) if move_sibling
    when ']'
      move_v([pos[0] - 1, pos[1]], dir, map, move_sibling: false) if move_sibling
    end
    map[next_pos] = cur_char
    map.delete(pos)
  end
end
