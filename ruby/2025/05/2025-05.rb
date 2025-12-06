#!/usr/local/bin/ruby

require_relative '../../util/range'

# This program answers Advent of Code 2025 day 05
#
# Author::    Andre Onuki
# License::   GPL3
class Solver
  def solve(input_ranges, ingredients)
    ranges = Ranges.new
    input_ranges.map { |r| r.split('-').map(&:to_i) }
                .each { |r| ranges.add(r) }
    ingredients.map(&:to_i)
               .select { |ingr| ranges.in?(ingr) }
               .size
  end

  def solve2(input_ranges)
    ranges = Ranges.new
    input_ranges.map { |r| r.split('-').map(&:to_i) }
                .each { |r| ranges.add(r) }
    ranges.to_a
          .map { |a| a[1] - a[0] + 1 }
          .sum
  end
end
