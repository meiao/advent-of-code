#!/usr/local/bin/ruby

# This program answers Advent of Code 2021 day 02
#
# Author::    Andre Onuki
# License::   GPL3
class Solver
  def solve(input)
    depth = 0
    forward = 0

    input.each do |line|
      cmd, value = line.split(' ')
      case cmd
      when 'forward'
        forward += value.to_i
      when 'down'
        depth += value.to_i
      when 'up'
        depth -= value.to_i
        depth = 0 if depth < 0
      end
    end

    depth * forward
  end

  def solve2(input)
    depth = 0
    forward = 0
    aim = 0

    input.each do |line|
      cmd, value = line.split(' ')
      case cmd
      when 'forward'
        forward += value.to_i
        depth += aim * value.to_i
        depth = 0 if depth < 0
      when 'down'
        aim += value.to_i
      when 'up'
        aim -= value.to_i
      end
    end

    depth * forward
  end
end
