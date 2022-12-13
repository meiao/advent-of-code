#!/usr/local/bin/ruby

# This program answers Advent of Code 2022 day 13
#
# This version ran in
#
# Author::    Andre Onuki
# License::   GPL3
class Solver
  def solve(input)
    index = 1
    sum = 0
    until input.empty?
      left, right, _blank = input.shift(3)
      sum += index if compare(eval(left), eval(right)) < 0
      index += 1
    end
    sum
  end

  def solve2(input)
    items = input
      .filter{|line| !line.strip.empty?}
      .map{|line| eval(line)}
    items << [[2]]
    items << [[6]]
    items.sort!{|a,b| compare(a,b)}
    (items.index([[2]])+1) * (items.index([[6]])+1)
  end

  def compare(left, right)
    left_is_num = left.is_a?(Numeric)
    right_is_num = right.is_a?(Numeric)
    return left <=> right if left_is_num && right_is_num

    return compare([left], right) if left_is_num
    return compare(left, [right]) if right_is_num

    [left.size, right.size].min.times do |i|
      diff = compare(left[i], right[i])
      return diff if diff != 0
    end
    return left.size <=> right.size
  end
end
