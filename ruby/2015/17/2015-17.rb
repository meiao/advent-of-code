#!/usr/local/bin/ruby

# This program answers Advent of Code 2015 day 17
#
# Author::    Andre Onuki
# License::   GPL3
class Solver
  def solve(input, target)
    buckets = input.map { |line| line.to_i }
    solutions = 0
    possibles = []
    buckets.each do |bucket|
      next_possible = [bucket]
      possibles.each do |sum|
        next if sum + bucket > target

        if sum + bucket == target
          solutions += 1
        else
          next_possible << sum + bucket
        end
        next_possible << sum
      end
      possibles = next_possible
    end
    solutions
  end

  def solve2(input, target)
    buckets = input.map { |line| line.to_i }
    solutions = []
    possibles = []
    buckets.each do |bucket|
      next_possible = [[bucket]]
      possibles.each do |combination|
        sum = combination.sum
        next if sum + bucket > target

        if sum + bucket == target
          solutions << (combination.clone << bucket)
        else
          next_possible << (combination.clone << bucket)
        end
        next_possible << combination
      end
      possibles = next_possible
    end
    sizes = Hash.new(0)
    solutions.each do |combination|
      sizes[combination.size] += 1
    end
    sizes[sizes.keys.min]
  end
end
