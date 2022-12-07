#!/usr/local/bin/ruby

# This program answers Advent of Code 2022 day 06
#
# This version ran in
#
# Author::    Andre Onuki
# License::   GPL3
class Solver
  def solve(input, distinct)
    chars = input[0].strip.chars
    initial_size = chars.size
    window = chars.shift(distinct)
    while (window.uniq.size < distinct)
      window.shift
      window << chars.shift
      break if chars.empty?
    end
    initial_size - chars.size
  end
end
