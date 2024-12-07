#!/usr/local/bin/ruby

# This program answers Advent of Code 2024 day 07
#
# Author::    Andre Onuki
# License::   GPL3
class Solver
  def solve(input)
    ops = [->(n1, n2) { n1 * n2 }, ->(n1, n2) { n1 + n2 }]
    input.map do |line|
      calculate(line, ops)
    end.sum
  end

  def solve2(input)
    ops = [->(n1, n2) { n1 * n2 }, ->(n1, n2) { n1 + n2 }, ->(n1, n2) { concat(n1, n2) }]
    input.map do |line|
      calculate(line, ops)
    end.sum
  end

  def calculate(line, operations)
    total, nums = line.split(':')
    total = total.to_i
    nums = nums.split(' ').map(&:to_i)
    return total if solvable(operations, total, nums, nums[0], 1)

    0
  end

  def solvable(ops, total, nums, acc, i)
    return acc == total if i == nums.size
    return false if acc > total

    ops.any? { |op| solvable(ops, total, nums, op.call(acc, nums[i]), i + 1) }
  end

  def concat(n1, n2)
    copy = n2
    # there are no '0's in the input, else the code below would break
    while copy > 0
      n1 *= 10
      copy /= 10
    end
    n1 + n2
  end
end
