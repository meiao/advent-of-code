#!/usr/local/bin/ruby

# This program answers Advent of Code 2023 day 14
#
# This version ran in
#
# Author::    Andre Onuki
# License::   GPL3
class Solver
  def solve(input)
    @@max_x = input[0].size
    @@max_y = input.size
    map = make_map(input)
    move_rocks(map, [0, -1])
    max_load = input.size
    map.filter { |_k, v| v == 'O' }.map { |k, _v| max_load - k[1] }.sum
  end

  def make_map(input)
    map = Hash.new('.')
    input.each_with_index do |line, y|
      line.size.times do |x|
        map[[x, y]] = line[x] if line[x] != '.'
      end
    end
    map
  end

  def print_map(map)
    10.times do |y|
      10.times do |x|
        print map[[x, y]]
      end
      puts
    end
  end

  def move_rocks(map, direction)
    map.filter { |_k, v| v == 'O' }.each do |k, _v|
      move_rock(map, direction, k)
    end
  end

  def move_rock(map, dir, k)
    good_pos = k
    previous_pos = k
    loop do
      next_pos = [previous_pos[0] + dir[0], previous_pos[1] + dir[1]]
      break if next_pos.min < 0 || next_pos[1] >= @@max_y || next_pos[0] >= @@max_x || map[next_pos] == '#'

      previous_pos = next_pos
      good_pos = next_pos if map[next_pos] == '.'
    end
    map.delete(k)
    map[good_pos] = 'O'
  end

  def cycle_rocks(map)
    move_rocks(map, [0, -1])
    move_rocks(map, [-1, 0])
    move_rocks(map, [0, 1])
    move_rocks(map, [1, 0])
  end

  def solve2(input)
    @@max_x = input[0].size
    @@max_y = input.size
    map = make_map(input)
    max_load = input.size
    1_000_000_000.times do |i|
      cycle_rocks(map)
      p [i + 1, map.filter { |_k, v| v == 'O' }.map { |k, _v| max_load - k[1] }.sum]
    end
    map.filter { |_k, v| v == 'O' }.map { |k, _v| max_load - k[1] }.sum
  end
end
