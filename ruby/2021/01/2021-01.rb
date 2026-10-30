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

    prev = 1_000_000_000
    window = [0]
    increasing = 0
    window << values.shift
    window << values.shift
    values.each do |x|
      window.shift
      window << x
      current = window.sum
      increasing += 1 if current > prev
      prev = current
    end
    increasing
  end
end
