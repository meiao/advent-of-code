#!/usr/local/bin/ruby

# This program answers Advent of Code 2025 day 11
#
# Author::    Andre Onuki
# License::   GPL3
class Solver
  def initialize(input)
    @map = input.map(&:strip)
                .map { |line| line.split(': ') } # aaa: bbb ccc => ['aaa', 'bbb ccc']
                .to_h { |arr| [arr[0], arr[1].split(' ')] } # ['aaa', 'bbb ccc'] => ['aaa', ['bbb', 'ccc']] => to_h
    @cache = {}
  end

  # Calculates the number of paths between src and dst
  def solve(src, dst)
    return 1 if src == dst
    return 0 if @map[src].nil?

    cache_key = [src, dst]
    cached_val = @cache[cache_key]
    unless cached_val.nil?
      # assuming cyclic paths do not count
      return 0 if cached_val == -1

      return cached_val
    end

    # marking that this path is being calculated, to avoid cycles
    @cache[cache_key] = -1
    count = @map[src].map { |next_step| solve(next_step, dst) }
                     .sum
    @cache[cache_key] = count
    count
  end
end
