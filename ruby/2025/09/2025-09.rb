#!/usr/local/bin/ruby

# This program answers Advent of Code 2025 day 09
#
# Author::    Andre Onuki
# License::   GPL3

require_relative '../../util/neighbors'

class Solver
  include HasNeighbors

  def solve(input, anything_goes)
    points = input.map { |line| line.split(',').map(&:to_i) }
    if anything_goes
      validator = method(:always_true?)
    else
      validator = method(:valid?)
      map = build_map(points)
    end
    points.combination(2)
          .map { |points| [area(points[0], points[1]), points] }
          .sort { |a, b| b[0] <=> a[0] }
          .find { |data| validator.call(data[1], map) }[0]
  end

  def build_map(points)
    map = Hash.new(false)
    points.each_with_index do |pi, i|
      xs = [pi[0], points[i - 1][0]].sort
      ys = [pi[1], points[i - 1][1]].sort

      (xs[0]..xs[1]).each do |x|
        (ys[0]..ys[1]).each do |y|
          map[[x, y]] = true
        end
      end
    end
    # this will be the first internal point in the polygon
    left_top = points.min.map { |v| v + 1 }
    map[left_top] = true
    queue = [left_top]
    until queue.empty?
      point = queue.shift
      neighbors(point).each do |n|
        unless map[n]
          map[n] = true
          queue << n
        end
      end
    end
    map
  end

  def area(p1, p2)
    # adds 1 to the difference because the rectangle (2,0)/(3,0) has 2 squares (2, 3), but 3 - 2 = 1
    ((p1[0] - p2[0] + 1) * (p1[1] - p2[1] + 1)).abs
  end

  def always_true?(_, _)
    true
  end

  def valid?(points, map)
    xs = points.map { |p| p[0] }
    ys = points.map { |p| p[1] }
    xs.sort.each do |x|
      ys.sort.each do |y|
        return false unless map[[x, y]]
      end
    end
    true
  end
end
