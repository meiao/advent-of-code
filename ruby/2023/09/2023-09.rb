#!/usr/local/bin/ruby

# This program answers Advent of Code 2023 day 09
#
# Author::    Andre Onuki
# License::   GPL3
class Solver
  def solve(input)
    input.map{|line| extrapolate(line)}.sum
  end

  def extrapolate(line)
    numbers = []
    numbers << line.split(' ').map{|n| n.to_i}
    while (changing(numbers[-1]))
      numbers << difference(numbers[-1])
    end
    extrapolated = 0
    while !numbers.empty?
      extrapolated += numbers.pop[-1]
    end
    extrapolated
  end

  def changing(numbers)
    numbers.uniq.size != 1
  end

  def difference(numbers)
    diff = []
    (1..(numbers.size-1)).each do |i|
      diff << numbers[i] - numbers[i-1]
    end
    diff
  end

  def solve2(input)
    input.map{|line| extrapolate_backwards(line)}.sum
  end

  def extrapolate_backwards(line)
    numbers = []
    numbers << line.split(' ').map{|n| n.to_i}
    while (changing(numbers[-1]))
      numbers << difference(numbers[-1])
    end
    extrapolated = 0
    while !numbers.empty?
      extrapolated = numbers.pop[0] - extrapolated
    end
    extrapolated
  end
end
