#!/usr/local/bin/ruby

# This program answers Advent of Code 2015 day 18
#
# This version ran in
#
# Author::    Andre Onuki
# License::   GPL3
class Solver
  def solve(input)
    map = Map.new(input)
    100.times { |_| map.cycle }
    map.lit_up
  end
end

class Solver2
  def solve(input)
    map = Map.new(input)
    map.light_corners
    100.times { |_| map.cycle2 }
    map.lit_up
  end
end

class Map
  def initialize(input)
    @size = input.size
    @lights = Hash.new(false)
    input.each_with_index do |line, y|
      line.rstrip.chars.each_with_index do |char, x|
        @lights[[x, y]] = true if char == '#'
      end
    end
    @corners = [
      [0, 0],
      [@size - 1, 0],
      [0, @size - 1],
      [@size - 1, @size - 1]
    ]
  end

  def print_map
    @size.times do |y|
      @size.times do |x|
        char = @lights[[x, y]] ? '#' : '.'
        print char
      end
      puts
    end
    puts
  end

  def cycle
    illumination = Hash.new(0)
    @lights.keys.each do |coord|
      [-1, 0, 1].each do |x|
        [-1, 0, 1].each do |y|
          cx = coord[0] + x
          cy = coord[1] + y
          next if (x == 0 && y == 0) || cx < 0 || cy < 0 || cx >= @size || cy >= @size

          illumination[[cx, cy]] += 1
        end
      end
    end
    next_lights = Hash.new(false)
    illumination.each_pair do |coord, count|
      next_lights[coord] = true if count == 3 || (count == 2 && @lights[coord])
    end
    @lights = next_lights
  end

  def light_corners
    @corners.each { |coord| @lights[coord] = true }
  end

  def cycle2
    cycle
    light_corners
  end

  def lit_up
    @lights.size
  end
end
