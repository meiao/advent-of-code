#!/usr/local/bin/ruby

# This program answers Advent of Code 2025 day 12
#
# This solution assumes that the shapes will be able to be placed in the regions as long
# as the total area of the shapes is less than the total area of the region.
#
# Author::    Andre Onuki
# License::   GPL3
class Solver
  def initialize(input)
    @shape_area = []
    input.each do |line|
      next if line.empty?

      if line[0].match?(/\d/)
        @shape_area << 0
      else
        @shape_area[-1] += line.count('#')
      end
    end
    p @shape_area
  end

  def solve(regions)
    regions.count { |region| valid?(region) }
  end

  def valid?(region)
    area, counts = region.split(': ')
    available_area = area.split('x')
                         .map(&:to_i)
                         .inject(:*)
    used_area = counts.split(' ').map(&:to_i).zip(@shape_area).map { |(a, b)| a * b }.sum
    p [available_area, used_area]
    available_area > used_area
  end
end
