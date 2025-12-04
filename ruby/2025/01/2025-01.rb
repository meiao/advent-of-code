#!/usr/local/bin/ruby

# This program answers Advent of Code 2025 day 01
#
# Author::    Andre Onuki
# License::   GPL3
class Solver
  def solve(input)
    dial = Dial.new
    zeroes = 0
    input.each do |cmd|
      dial.rotate(cmd)
      zeroes += 1 if dial.num == 0
    end
    zeroes
  end

  def solve2(input)
    dial = Dial.new
    prev = dial.num
    zeroes = 0
    input.each do |cmd|
      zeroes += passed_0(prev, cmd)
      prev = dial.rotate(cmd)
    end
    zeroes
  end

  def passed_0(prev, cmd)
    value = cmd[1..].to_i
    if cmd[0] == 'R' || prev == 0
      (prev + value) / 100
    else
      (100 - prev + value) / 100
    end
  end
end

class Dial
  attr_reader :num

  def initialize
    @num = 50
  end

  def rotate(cmd)
    value = cmd[1..].to_i
    if cmd[0] == 'R'
      @num += value
    else
      @num -= value
    end
    @num %= 100
    @num
  end
end
