#!/usr/local/bin/ruby

# This program answers Advent of Code 2022 day 03
#
# This version ran in
#
# Author::    Andre Onuki
# License::   GPL3
class Solver
  def solve(input)
    sum = 0
    input.each do |rucksack|
      compartments = rucksack.strip.chars.each_slice(rucksack.size / 2).to_a
      dupe = compartments[0].intersection(compartments[1])[0]
      if dupe.match(/[a-z]/)
        sum += dupe.ord - 'a'.ord
      else
        sum += dupe.ord - 'A'.ord + 26
      end
    end
    sum + input.size
  end
end

class Solver2
  def solve(input)
    sum = 0
    while !input.empty?
      elves = []
      3.times { elves << input.shift.strip.chars }
      dupe = elves[0].intersection(elves[1]).intersection(elves[2])[0]
      if dupe.match(/[a-z]/)
        sum += dupe.ord - 'a'.ord + 1
      else
        sum += dupe.ord - 'A'.ord + 27
      end
    end
    sum
  end
end
