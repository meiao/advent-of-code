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
    sorted = nums.sort
    return false unless nums == sorted || nums == sorted.reverse
    for i in 0..(nums.length - 2)
      diff = (nums[i] - nums[i+1]).abs
      if diff == 0 || diff > 3
        return false
      end
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
    for i in 0..(nums.length - 1)
      without_i = nums.dup
      without_i.delete_at(i)
      return true if safe?(without_i)
    end
    false
  end
end
