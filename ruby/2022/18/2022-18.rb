#!/usr/local/bin/ruby

# This program answers Advent of Code 2022 day 18
#
# This version ran in
#
# Author::    Andre Onuki
# License::   GPL3
class Solver
  def solve(input)
    map = Hash.new(false)
    input.each do |line|
      coords = line.split(',').map { |n| n.to_i }
      map[coords] = true
    end

    area = map.size * 6

    map.keys.each do |coord|
      air_coord = []
      (-1..1).each do |x|
        (-1..1).each do |y|
          (-1..1).each do |z|
            next if x.abs + y.abs + z.abs != 1

            checking_coord = [coord[0] + x, coord[1] + y, coord[2] + z]
            air_coord << checking_coord unless map[checking_coord]
          end
        end
      end
      area -= 6 - air_coord.size
    end
    area
  end
end

class Solver2
  def solve(input)
    map = Hash.new(false)
    input.each do |line|
      coords = line.split(',').map { |n| n.to_i }
      map[coords] = true
    end

    area = map.size * 6
    possible_bubble = Hash.new(0)
    map.keys.each do |coord|
      air_coord = []
      for_neighbors do |x, y, z|
        checking_coord = [coord[0] + x, coord[1] + y, coord[2] + z]
        air_coord << checking_coord unless map[checking_coord]
      end
      area -= 6 - air_coord.size
      air_coord.each do |coord|
        possible_bubble[coord] += 1
      end
    end

    single_bubbles = possible_bubble.filter { |_k, v| v == 6 }
    area -= 6 * single_bubbles.size
    single_bubbles.each_key { |k| possible_bubble.delete(k) }
    area -= total_bubble_area(possible_bubble.keys, map)
    area
  end

  def total_bubble_area(possible_bubble, map)
    area = 0
    until possible_bubble.empty?
      bubble = single_bubble(possible_bubble.shift, map)
      area += bubble.area if bubble.is_bubble
      bubble.coords.each do |c|
        possible_bubble.delete(c)
      end
    end
    area
  end

  def single_bubble(coord, map)
    area = 0
    queue = [coord]
    visited_air = Hash.new(false)
    until queue.empty? || visited_air.size + queue.size >= map.size
      cur = queue.shift
      for_neighbors do |x, y, z|
        neighbor = [cur[0] + x, cur[1] + y, cur[2] + z]
        if map[neighbor]
          area += 1
        else
          queue << neighbor unless visited_air[neighbor] || queue.include?(neighbor)
        end
      end
      visited_air[cur] = true
    end
    bubble_coords = visited_air.keys.concat(queue)
    Bubble.new(queue.empty?, area, bubble_coords)
  end

  def for_neighbors(&block)
    (-1..1).each do |x|
      (-1..1).each do |y|
        (-1..1).each do |z|
          next if x.abs + y.abs + z.abs != 1

          block.call(x, y, z)
        end
      end
    end
  end
end

class Bubble
  attr_reader :is_bubble, :area, :coords

  def initialize(is_bubble, area, coords)
    @is_bubble = is_bubble
    @area = area
    @coords = coords
  end
end
