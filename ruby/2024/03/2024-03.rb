#!/usr/local/bin/ruby

# This program answers Advent of Code 2024 day 03
#
# Author::    Andre Onuki
# License::   GPL3
class Solver
  def solve(input)
    re = /(mul\(\d{1,3},\d{1,3}\))/
    cmds = process_input(input, re)
    execute(cmds)
  end

  def solve2(input)
    re = /(do\(\))|(mul\(\d{1,3},\d{1,3}\))|(don't\(\))/
    cmds = process_input(input, re)
    execute(cmds)
  end
end

def process_input(input, re)
  input.map { |line| line.scan(re) }
       .flatten
       .compact
end

# cmds is a list of strings that contains valid cmds
# do(), don't() or mul(x,y)
def execute(cmds)
  sum = 0
  enabled = true
  cmds.each do |cmd|
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
