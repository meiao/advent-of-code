#!/usr/local/bin/ruby

# This program answers Advent of Code 2023 day 13
#
# This version ran in
#
# Author::    Andre Onuki
# License::   GPL3
class Solver
  def solve(maps)
    maps.map{|map| calculate(map)}.sum
  end

  def calculate(map)
    line = find_reflection_line(map)
    if line != nil
      return 100 * (line + 1)
    end
    map = rotate(map)
    line = find_reflection_line(map)
    if line != nil
      return (line + 1)
    end
    puts
  end

  def find_reflection_line(map)
    (map.size - 1).times do |i|
      return i if map[i] == map[i+1] && verify_line(map, i)
    end
    nil
  end

  def verify_line(map, line)
    i = 0
    while line - i >= 0 && line + i + 1 < map.size
      return false if map[line - i] != map[line + 1 + i]
      i += 1
    end
    true
  end

  def rotate(map)
    new_map = []
    map[0].size.times do
      new_map << []
    end
    map.size.times do |i|
      map[0].size.times do |j|
        new_map[j][i] = map[i][j]
      end
    end
    new_map.map{|line| line.join}
  end

  def print_map(map)
    map.each do |line|
      p line
    end
  end
end

class Solver2
  def solve(maps)
    maps.map{|map| calculate(map)}.sum
  end

  def calculate(map)
    line = find_reflection_line(map)
    if line != nil
      return 100 * (line + 1)
    end
    map = rotate(map)
    line = find_reflection_line(map)
    if line != nil
      return (line + 1)
    end
  end

  def rotate(map)
    new_map = []
    map[0].size.times do
      new_map << []
    end
    map.size.times do |i|
      map[0].size.times do |j|
        new_map[j][i] = map[i][j]
      end
    end
    new_map.map{|line| line.join}
  end

  def find_reflection_line(map)
    map.size.times do |i|
      return i if diff(map, i) == 1
    end
    nil
  end

  def diff(map, line)
    count = 0
    i = 0
    while line - i >= 0 && line + i + 1 < map.size
      count += diff_lines(map[line-i], map[line+i+1])
      return count if count > 1
      i += 1
    end
    count
  end

  def diff_lines(line1, line2)
    line1.size.times.count{|i| line1[i] != line2[i]}
  end
end
