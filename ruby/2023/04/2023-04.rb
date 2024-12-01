#!/usr/local/bin/ruby

# This program answers Advent of Code 2023 day 04
#
# Author::    Andre Onuki
# License::   GPL3
class Solver
  def solve(input)
    points = [0, 1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024]
    sum = 0
    input.each do |line|
      numbers = line.split(':')[1]
      winning, own = numbers.split(' | ').map { |list| list.split(' ') }
      matches = 0
      winning.each do |n|
        matches += 1 if own.include? n
      end
      sum += points[matches]
    end
    sum
  end

  def solve2(input)
    copies = Array.new(input.size, 1)
    input.size.times do |i|
      numbers = input[i].split(':')[1]
      winning, own = numbers.split(' | ').map { |list| list.split(' ') }
      matches = 0
      winning.each do |n|
        matches += 1 if own.include? n
      end
      matches.times do |j|
        copies[i + j + 1] += copies[i]
      end
    end
    copies.sum
  end
end
