#!/usr/local/bin/ruby

# This program answers Advent of Code 2022 day 25
#
# This version ran in
#
# Author::    Andre Onuki
# License::   GPL3

module Snafu
  def self.from_dec(dec)
    snafu = []
    while dec > 0
      mod5 = dec % 5
      dec /= 5
      case mod5
      when 0..2
        snafu.unshift(mod5.to_s)
      when 3
        snafu.unshift('=')
        dec += 1
      when 4
        snafu.unshift('-')
        dec += 1
      end
    end
    return snafu.join
  end

  def self.to_dec(snafu)
    dec = 0
    chars = snafu.split('')
    until chars.empty?
      dec *= 5
      char = chars.shift
      case char
      when '0', '1', '2'
        dec += char.to_i
      when '='
        dec -= 2
      when '-'
        dec -= 1
      end
    end
    dec
  end
end

class Solver
  def solve(input)
    sum = input.map{|line| Snafu.to_dec(line.strip)}.sum
    Snafu::from_dec(sum)
  end
end

class Solver2
  def solve
  end
end
