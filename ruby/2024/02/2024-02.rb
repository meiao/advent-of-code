#!/usr/local/bin/ruby

# This program answers Advent of Code 2024 day 02
#
# Author::    Andre Onuki
# License::   GPL3
class Solver
  def solve(input)
    safe = 0
    input.each do |line|
      nums = line.split(' ').map(&:to_i)
      safe += 1 if safe?(nums)
    end
    safe
  end

  def safe?(nums)
    return false unless nums.sorted? || nums.reverse.sorted?

    (0..(nums.length - 2)).each do |i|
      diff = (nums[i] - nums[i + 1]).abs
      return false if diff == 0 || diff > 3
    end
    true
  end

  def solve2(input)
    safe = 0
    input.each do |line|
      nums = line.split(' ').map(&:to_i)
      safe += 1 if safe2?(nums)
    end
    safe
  end

  def safe2?(nums)
    return true if safe?(nums)

    (0..(nums.length - 1)).each do |i|
      without_i = nums.dup
      without_i.delete_at(i)
      return true if safe?(without_i)
    end
    false
  end
end

module Enumerable
  def sorted?
    each_cons(2).all? { |a, b| (a <=> b) <= 0 }
  end
end
