#!/usr/local/bin/ruby

# This program answers Advent of Code 2024 day 01
#
# Author::    Andre Onuki
# License::   GPL3
class Solver
  def solve(input)
    list1, list2 = get_lists(input)
    sum = 0
    (0..(list1.length - 1)).each do |i|
      sum += (list1[i] - list2[i]).abs
    end
    sum
  end

  def get_lists(input)
    list1 = []
    list2 = []
    input.each do |line|
      n1, n2 = line.split(' ').map(&:to_i)
      list1 << n1
      list2 << n2
    end
    list1.sort!
    list2.sort!
    [list1, list2]
  end

  def solve2(input)
    count_map = Hash.new(0)
    valid_keys = []
    input.each do |line|
      n1, n2 = line.split(' ').map(&:to_i)
      valid_keys << n1
      count_map[n2] += 1
    end
    valid_keys.map do |key|
      key * count_map[key]
    end.sum
  end
end
