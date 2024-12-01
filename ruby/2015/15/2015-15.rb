#!/usr/local/bin/ruby

# This program answers Advent of Code 2015 day 15
#
# Author::    Andre Onuki
# License::   GPL3
class Solver
  def solve(input, part1)
    brute_forcer = BruteForcer.new(input)
    brute_forcer.calc(part1)
  end
end

class BruteForcer
  def initialize(input)
    @matrix = input.map do |line|
      data = line.match(/[^:]+: capacity (-?\d), durability (-?\d), flavor (-?\d), texture (-?\d), calories (-?\d)/)
      [data[1].to_i, data[2].to_i, data[3].to_i, data[4].to_i, data[5].to_i]
    end
  end

  def calc(part1)
    max = 0
    (0..100).each do |i1|
      (0..(100 - i1)).each do |i2|
        (0..(100 - i1 - i2)).each do |i3|
          i4 = 100 - i1 - i2 - i3
          arr = [i1, i2, i3, i4]
          next if !part1 && calories(arr) != 500

          value = multiply(arr)
          max = value if value > max
        end
      end
    end
    max
  end

  def multiply(arr)
    value = 1
    4.times do |col|
      col_sum = 0
      4.times do |row|
        col_sum += arr[row] * @matrix[row][col]
      end
      return 0 if col_sum <= 0

      value *= col_sum
    end
    value
  end

  def calories(arr)
    cals = 0
    4.times do |i|
      cals += arr[i] * @matrix[i][-1]
    end
    cals
  end
end
