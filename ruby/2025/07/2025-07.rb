#!/usr/local/bin/ruby

# This program answers Advent of Code 2025 day 07
#
# Author::    Andre Onuki
# License::   GPL3
class Solver
  def solve(input)
    beam_index = input[0].index('S')
    beam_map = Hash.new(0)
    beam_map[beam_index] = 1
    simulate(input, 1, 0, beam_map)
  end

  def simulate(input, row, splits, beam_map)
    return [splits, beam_map.values.sum] if input[row].nil?

    next_beams = Hash.new(0)
    line = input[row]
    beam_map.each do |col, count|
      if line[col] == '.'
        next_beams[col] += count
      else
        splits += 1
        next_beams[col - 1] += count
        next_beams[col + 1] += count
      end
    end
    simulate(input, row + 1, splits, next_beams)
  end
end
