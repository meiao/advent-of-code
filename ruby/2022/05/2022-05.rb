#!/usr/local/bin/ruby

# This program answers Advent of Code 2022 day 05
#
# This version ran in
#
# Author::    Andre Onuki
# License::   GPL3
class Solver
  def solve(input)
    stacks = []
    stacks[0] = [''] # guard
    while true
      line = input.shift.strip.chars
      break if line.empty?

      column = line.pop.to_i
      stacks[column] = line
    end

    input.each do |line|
      _move, count, _from, from, _to, to = line.split(' ')
      stack = stacks[from.to_i].shift(count.to_i)
      stacks[to.to_i].unshift(stack.reverse).flatten!
    end

    top = ''
    stacks.each do |stack|
      top += stack[0]
    end
    top
  end
end

class Solver2
  def solve(input)
    stacks = []
    stacks[0] = [''] # guard
    while true
      line = input.shift.strip.chars
      break if line.empty?

      column = line.pop.to_i
      stacks[column] = line
    end

    input.each do |line|
      _move, count, _from, from, _to, to = line.split(' ')
      stack = stacks[from.to_i].shift(count.to_i)
      stacks[to.to_i].unshift(stack).flatten!
    end

    top = ''
    stacks.each do |stack|
      top += stack[0]
    end
    top
  end
end
