#!/usr/local/bin/ruby

# This program answers Advent of Code 2022 day 14
#
# This version ran in
#
# Author::    Andre Onuki
# License::   GPL3
class Solver
  def initialize(input)
    @map = {}
    @max_y = 0
    input.each { |line| read_rocks(line) }
  end

  def read_rocks(line)
    data = line.split(' -> ').map { |point| eval('[' + point.strip + ']') }
    prev_point = data[0]
    data[1..-1].each do |next_point|
      direction = [
        next_point[0] - prev_point[0],
        next_point[1] - prev_point[1]
      ].map { |v| v == 0 ? 0 : v / v.abs }
      while prev_point != next_point
        @map[Array.new(prev_point)] = '#'
        prev_point[0] += direction[0]
        prev_point[1] += direction[1]
        @max_y = prev_point[1] if prev_point[1] > @max_y
      end
    end
    @map[prev_point] = '#'
  end

  def solve
    new_origin([500, 0])
    # print_map
    @map.values.filter { |point| point == 'o' }.size
  end

  def new_origin(origin)
    point = Array.new(origin)
    while @map[point].nil?
      point[1] += 1
      return true if point[1] > @max_y
    end
    point[1] -= 1
    @map[Array.new(point)] = 'o'

    while point != origin
      point[1] -= 1
      return true if descent(point, -1)
      return true if descent(point, 1)

      @map[Array.new(point)] = 'o'
    end

    false
  end

  def descent(point, direction)
    this_point = [point[0] + direction, point[1] + 1]
    return false unless @map[this_point].nil?

    return new_origin(this_point) if @map[[this_point[0], this_point[1] + 1]].nil?

    return true if descent(this_point, direction)

    @map[Array.new(this_point)] = 'o'
    false
  end

  def print_map
    min_x = 500
    max_x = 500

    @map.keys.each do |point|
      min_x = point[0] - 1 if point[0] <= min_x
      max_x = point[0] + 1 if point[0] >= max_x
    end
    (0..(@max_y + 1)).each do |y|
      (min_x..max_x).each do |x|
        v = @map[[x, y]]
        print(v.nil? ? '.' : v)
      end
      puts
    end
  end
end

class Solver2 < Solver
  def initialize(input)
    super(input)
    max_y2 = @max_y + 2
    @max_y = max_y2 + 1
    @map.default_proc = proc { |_hash, key| key[1] == max_y2 ? '#' : nil }
  end
end
