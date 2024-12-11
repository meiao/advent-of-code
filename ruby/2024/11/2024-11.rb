#!/usr/local/bin/ruby

# This program answers Advent of Code 2024 day 11
#
# Author::    Andre Onuki
# License::   GPL3
class Solver
  def initialize
    @cache = {}
  end

  def solve(input, repetitions)
    hash = Hash.new(0)
    input[0].split(' ').map(&:to_i).each do |num|
      hash[num] = 1
    end

    repetitions.times do
      hash = iterate(hash)
    end
    hash.values.sum
  end

  def iterate(hash)
    next_hash = Hash.new(0)
    hash.each do |num, count|
      convert(num).each do |new_num|
        next_hash[new_num] += count
      end
    end
    next_hash
  end

  def convert(num)
    return [1] if num == 0

    cached = @cache[num]
    return cached unless cached.nil?

    size = num.to_s.size
    return [num * 2024] if size.odd?

    divisor = 10**(size / 2)
    calculated = [num / divisor, num % divisor]
    @cache[num] = calculated
    calculated
  end
end
