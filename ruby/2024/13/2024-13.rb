#!/usr/local/bin/ruby

# This program answers Advent of Code 2024 day 13
#
# Author::    Andre Onuki
# License::   GPL3
class Solver
  def solve(input)
    sum = 0
    until input.empty?
      sum += solve_single(input.shift(3), 0)
      input.shift # remove empty line
    end
    sum
  end

  def solve_single(lines, correction)
    button_regex = /X(?<x>[+\-][0-9]+), Y(?<y>[+\-][0-9]+)/
    a = button_regex.match(lines[0]).named_captures
    b = button_regex.match(lines[1]).named_captures
    c = /Prize: X=(?<x>\d+), Y=(?<y>\d+)/.match(lines[2]).named_captures
    ax = a['x'].to_i
    ay = a['y'].to_i
    bx = b['x'].to_i
    by = b['y'].to_i
    cx = c['x'].to_i + correction
    cy = c['y'].to_i + correction

    b_num = cx * ay - cy * ax
    b_den = bx * ay - by * ax
    return 0 unless b_num % b_den == 0

    b = b_num / b_den

    a_num = cx - b * bx
    a_den = ax
    return 0 unless a_num % a_den == 0

    a = a_num / a_den
    3 * a + b
  end

  def solve2(input)
    sum = 0
    until input.empty?
      sum += solve_single(input.shift(3), 10_000_000_000_000)
      input.shift # remove empty line
    end
    sum
  end
end
