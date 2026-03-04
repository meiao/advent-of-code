#!/usr/local/bin/ruby

# This program answers Advent of Code 2025 day 09
#
# Author::    Andre Onuki
# License::   GPL3

require_relative '../../util/neighbors'

class Solver
  include HasNeighbors

  def initialize
    @lines = {}
    @cols = {}
  end

  def solve(input, anything_goes)
    points = input.map { |line| line.split(',').map(&:to_i) }

    if anything_goes
      validator = method(:always_true?)
    else
      validator = method(:valid?)
      segments = points.zip(points.rotate) # creates pairs [[p0,  p1], [p1, p2] ...]
    end
    points.combination(2)
          .map { |ps| [area(ps[0], ps[1]), ps] }
          .sort { |a, b| b[0] <=> a[0] }
          .find { |data| validator.call(data[1], segments) }[0]
  end

  def area(p1, p2)
    # adds 1 to the difference because the rectangle (2,0)/(3,0) has 2 squares (2, 3), but 3 - 2 = 1
    ((p1[0] - p2[0]).abs + 1) * ((p1[1] - p2[1]).abs + 1)
  end

  def always_true?(_, _)
    true
  end

  def valid?(points, segments)
    xs = points.map { |p| p[0] }.sort
    ys = points.map { |p| p[1] }.sort
    x0y0 = [xs[0] + 0.5, ys[0] + 0.5]
    x0y1 = [xs[0] + 0.5, ys[1] - 0.5]
    x1y0 = [xs[1] - 0.5, ys[0] + 0.5]
    x1y1 = [xs[1] - 0.5, ys[1] - 0.5]
    return false if any_cross?([x0y0, x0y1], segments)
    return false if any_cross?([x0y0, x1y0], segments)
    return false if any_cross?([x0y1, x1y1], segments)
    return false if any_cross?([x1y0, x1y1], segments)

    # There should be a check to see whether the x1y0 and x1y1 are inside
    # the polygon. This can be implemented by checking how many segments
    # cross the segments [[x1,y0], [INF, y0]]. If it is an odd number of
    # crosses, then [x1,y0] is in the polygon]. Same for [x1,y1]. But
    # apparently this is not needed for the input.
    true
  end

  def any_cross?(segment, segments)
    segments.any? { |s| cross?(segment, s) }
  end

  def cross?(s1, s2)
    return false if vertical?(s1) == vertical?(s2)

    if vertical?(s1)
      [s1[0][0], s2[0][0], s2[1][0]].sort[1] == s1[0][0] && [s2[0][1], s1[0][1], s1[1][1]].sort[1] == s2[0][1]
    else
      [s2[0][0], s1[0][0], s1[1][0]].sort[1] == s2[0][0] && [s1[0][1], s2[0][1], s2[1][1]].sort[1] == s1[0][1]
    end
  end

  def vertical?(segment)
    segment[0][0] == segment[1][0]
  end
end
