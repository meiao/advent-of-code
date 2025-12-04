#!/usr/local/bin/ruby

# This program answers Advent of Code 2025 day 01
#
# Author::    Andre Onuki
# License::   GPL3
class Solver
  def solve(input)
    dial = Dial.new
    input.each do |cmd|
      dial.rotate(cmd)
    end
    dial
  end
end

class Dial
  attr_reader :num, :at_zero, :passed_zero

  def initialize
    @num = 50
    @at_zero = 0
    @passed_zero = 0
  end

  def rotate(cmd)
    was_at_zero = @num == 0
    value = cmd[1..].to_i
    if cmd[0] == 'R'
      @num += value
    else
      @num -= value
    end
    @passed_zero += @num.abs / 100
    @passed_zero += 1 if @num == 0
    @passed_zero += 1 if @num < 0 && !was_at_zero

    @num %= 100
    @at_zero += 1 if @num == 0
  end
end
