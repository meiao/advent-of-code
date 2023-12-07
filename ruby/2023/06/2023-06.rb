#!/usr/local/bin/ruby

# This program answers Advent of Code 2023 day 06
#
# Author::    Andre Onuki
# License::   GPL3
class Solver
  def solve(input)
    times = input[0].split(':')[1].split(' ').map{|n| n.to_i}
    distances = input[1].split(':')[1].split(' ').map{|n| n.to_i}
    result = 1
    times.size.times do |i|
      result *= calc(times[i], distances[i])
      p result
    end
    result
  end

  def calc(t, d)
    root = Math.sqrt(t**2 - 4*d)
    min = ((t-root)/2)
    if min.ceil == min
      min += 1
    else
      min = min.ceil
    end
    max = ((t+root)/2)
    if max.floor == max
      max -= 1
    else
      max = max.floor
    end
    p [t, d, min, max, max-min + 1]
    (max - min + 1).to_i
  end

  def solve2(input)
    time = input[0].split(':')[1].split(' ').join.to_i
    distance = input[1].split(':')[1].split(' ').join.to_i
    calc(time, distance)
  end
end
