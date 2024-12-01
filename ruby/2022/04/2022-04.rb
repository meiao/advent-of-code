#!/usr/local/bin/ruby

# This program answers Advent of Code 2022 day 04
#
# This version ran in
#
# Author::    Andre Onuki
# License::   GPL3
class Solver
  def solve(input)
    fully_contained = 0
    input.each do |line|
      elfs = line.strip.split(',').map { |range| range.split('-').map { |n| n.to_i } }
      fully_contained += 1 if contained?(elfs)
    end
    fully_contained
  end

  def contained?(elfs)
    return true if elfs[0][0] >= elfs[1][0] && elfs[0][1] <= elfs[1][1]
    return true if elfs[1][0] >= elfs[0][0] && elfs[1][1] <= elfs[0][1]

    false
  end
end

class Solver2
  def solve(input)
    fully_contained = 0
    input.each do |line|
      elfs = line.strip.split(',').map { |range| range.split('-').map { |n| n.to_i } }
      fully_contained += 1 if overlaps?(elfs)
    end
    fully_contained
  end

  def overlaps?(elfs)
    return true if elfs[0][0] <= elfs[1][1] && elfs[0][1] >= elfs[1][0]
    return true if elfs[1][0] <= elfs[0][1] && elfs[1][1] >= elfs[0][0]

    false
  end
end
