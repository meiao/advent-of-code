#!/usr/local/bin/ruby
require_relative 'picross'
# This program answers Advent of Code 2023 day 12
#
# Author::    Andre Onuki
# License::   GPL3
class Solver
  def solve(input)
    input.map do |line|
      data = line.split
      springs = data[0]
      numbers = data[1].split(',').map{|n| n.to_i}
      val = Picross.new(springs, numbers).calculate
      val
    end.sum
  end

  def solve2(input)
    input.map do |line|
      data = line.split
      springs = ((data[0]+'?')*5)[0..-2]
      numbers = ((data[1]+',')*5)[0..-2].split(',').map{|n| n.to_i}
      p [line]
      val = Picross.new(springs, numbers).calculate
      val
    end.sum
  end

  def force_leading_broken(springs, numbers)
    found_broken = false
    changed = false
    numbers[0].times do |i|
      if found_broken
        if springs[i] == '?'
          springs[i] = '#'
          changed = true
        end
      elsif springs[i] == '#'
        found_broken = true
      end
    end

    if found_broken
      i = numbers[0]
      while springs[i] == '?'
        return changed if i > numbers[0] * 2 - 2
        i += 1
      end
      return changed if springs[i] == '#'
      i -= 1
      found_broken = false
      numbers[0].times do |j|
        if found_broken
          if springs[i-j] == '?'
            springs[i-j] = '#'
            changed = true
          end
        elsif springs[i-j] == '#'
          found_broken = true
        end
      end
    end
    changed
  end


end
