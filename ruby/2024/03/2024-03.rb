#!/usr/local/bin/ruby

# This program answers Advent of Code 2024 day 03
#
# Author::    Andre Onuki
# License::   GPL3
class Solver
  def solve(input)
    re = /mul\((\d{1,3}),(\d{1,3})\)/
    input.map { |line| line.scan(re) }
         .flatten(1)
         .map { |m| m[0].to_i * m[1].to_i }
         .sum
  end

  def solve2(input)
    re = /(do\(\))|(mul\(\d{1,3},\d{1,3}\))|(don't\(\))/
    sum = 0
    enabled = true
    input.map { |line| line.scan(re) }
         .flatten
         .compact
         .each do |cmd|
      if cmd == 'do()'
        enabled = true
      elsif cmd == 'don\'t()'
        enabled = false
      elsif enabled
        nums = cmd[4..-2].split(',').map(&:to_i)
        sum += nums[0] * nums[1]
      end
    end
    sum
  end
end
