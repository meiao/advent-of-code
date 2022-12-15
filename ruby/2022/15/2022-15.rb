#!/usr/local/bin/ruby

# This program answers Advent of Code 2022 day 15
#
# This version ran in
#
# Author::    Andre Onuki
# License::   GPL3
class Solver

  def initialize(input)
    @sensors = []
    input.each do |line|
      @sensors << Sensor.new(line)
    end
    @beacons = {}
    @sensors.each do |sensor|
      @beacons[sensor.beacon] = true
    end
  end

  def solve(row)
    ranges = @sensors.map{|s| s.x_at_row(row)}.compact
    ranges = minimize_ranges(ranges)
    covered_points = ranges.map{|r| r.size}.sum
    @beacons.keys.filter{|b| b[1] == row}.each do |b|
      covered_points -= 1 if ranges.any?{|r| r.include?(b[0])}
    end
    covered_points
  end

  def minimize_ranges(ranges)
    has_changes = true
    new_ranges = Array.new(ranges)
    while has_changes
      has_changes = false
      old_ranges = new_ranges.reverse
      new_ranges = []
      until old_ranges.empty?
        range = old_ranges.shift
        next if old_ranges.any?{|old_range| old_range.cover?(range)}
        old_ranges.each do |old_range|
          if old_range.first <= range.last && old_range.last >= range.first
            range = ([old_range.first, range.first].min..[old_range.last, range.last].max)
            has_changes = true
          end
        end
        new_ranges << range
      end
    end
    new_ranges
  end
end

class Sensor
  attr_reader :position, :beacon, :range
  def initialize(line)
    match = line.match(/x=(-?\d+), y=(-?\d+).*x=(-?\d+), y=(-?\d+)/)
    @position = [match[1].to_i, match[2].to_i]
    @beacon = [match[3].to_i, match[4].to_i]
    @range = (@position[0] - @beacon[0]).abs + (@position[1] - @beacon[1]).abs
  end

  def reads?(position)
    (@position[0] - position[0]).abs + (@position[1] - position[1]).abs <= @distance
  end

  def distance_to(point)
    (@position[0] - point[0]).abs + (@position[1] - point[1]).abs
  end

  def x_at_row(row)
    point = [@position[0], row]
    distance_to_point = distance_to(point)
    return nil if distance_to_point > @range
    points = []
    dist_diff = @range - distance_to_point
    min_x = @position[0] - dist_diff
    max_x = @position[0] + dist_diff
    (min_x..max_x)
  end

end


class Solver2
  def solve
  end
end
