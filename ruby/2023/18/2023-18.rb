#!/usr/local/bin/ruby

# This program answers Advent of Code 2023 day 18
#
# Author::    Andre Onuki
# License::   GPL3
class Solver

  @@dir = {
    'U' => [0, -1],
    'D' => [0, 1],
    'L' => [-1, 0],
    'R' => [1, 0]
  }

  def solve(input)
    map = make_map(input)
    left_top = [0, 0]
    map.keys.each do |k|
      left_top = k if k[0] < left_top[0] || (left_top[0] == k[0] && left_top[1] > k[1])
    end
    left_top[0] += 1
    left_top[1] += 1
    map[left_top] = '#'
    queue = [left_top]
    until queue.empty?
      pos = queue.pop
      @@dir.values.each do |dir|
        next_pos = [pos[0] + dir[0], pos[1] + dir[1]]
        next if map[next_pos] != '.'
        map[next_pos] = '#'
        queue << next_pos
      end
    end
    map.size
  end

  def make_map(input)
    map = Hash.new('.')
    pos = [0, 0]
    map[pos] = '#'
    input.each do |line|
      dir, count, color = line.split(' ')
      count.to_i.times do
        inc = @@dir[dir]
        pos = [pos[0] + inc[0], pos[1] + inc[1]]
        map[pos] = '#'
      end
    end
    map
  end


  def solve2(input)
  end
end
