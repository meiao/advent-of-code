#!/usr/local/bin/ruby

# This program answers Advent of Code 2024 day 19
#
# Author::    Andre Onuki
# License::   GPL3
class Solver
  def solve(patterns, input)
    make_maps(patterns)
    input.filter { |design| combinations(design) > 0 }.size
  end

  def combinations(design)
    count = @combinations_map[design]
    return count unless count.nil?

    count = 0
    @by_initial[design[0]].each do |pattern|
      next if pattern.size > design.size

      if design == pattern
        count += 1
      elsif design.start_with?(pattern)
        count += combinations(design[pattern.size..])
      end
    end
    @combinations_map[design] = count
    @combinations_map[design]
  end

  def make_maps(available_towels)
    @combinations_map = {}
    towels = available_towels.split(', ')
    @by_initial = Hash.new { |h, k| h[k] = [] }
    towels.each do |towel|
      @by_initial[towel[0]] << towel
    end
  end

  def solve2(patterns, input)
    make_maps(patterns)
    input.map { |design| combinations(design) }.sum
  end
end
