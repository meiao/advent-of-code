#!/usr/local/bin/ruby

# This program answers Advent of Code 2025 day 02
#
# Uses brute force. At this level, brute force still works.
# Runs in O(ranges * digits * digits/2).
#
# Author::    Andre Onuki
# License::   GPL3
class Solver
  def solve(input, max_reps)
    input.split(',')
         .map { |r| invalid_ids(r, max_reps).sum }.sum
  end

  def invalid_ids(range, max_reps)
    str_range = range.strip.split('-')
    first = str_range[0].to_i
    last = str_range[1].to_i
    # using a hash as a set for the keys
    invalid_ids = {}
    # max_num could be smaller, but my first heuristic gave the wrong answer
    max_num = '9' * (str_range[1].length / 2)
    ('1'..max_num).each do |num|
      (2..max_reps).each do |reps|
        numnum = (num * reps).to_i
        break if numnum > last

        invalid_ids[numnum] = true if numnum >= first
      end
    end
    invalid_ids.keys
  end
end
