#!/usr/local/bin/ruby

# This program answers Advent of Code 2021 day 01
#
# Author::    Andre Onuki
# License::   GPL3
class Solver
  def solve(input)
    values = input.map(&:to_i)

    prev = 1_000_000_000
    increasing = 0
    values.each do |x|
      increasing += 1 if x > prev
      prev = x
    end

    increasing
  end

  def solve2(input)
    values = input.map(&:to_i)

    increasing = 0
    (3..(values.size - 1)).each do |i|
      increasing += 1 if values[i - 3] < values[i]
    end
    increasing
  end
end
