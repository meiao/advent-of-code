#!/usr/local/bin/ruby

# This program answers Advent of Code 2025 day 06
#
# Author::    Andre Onuki
# License::   GPL3

class Solver
  def solve(input)
    ops = input[-1].split(' ')
    data = input[0..-2].map { |line| line.split(' ').map(&:to_i) }
    problems = []
    (ops.size - 1).downto(0).each do |i|
      op = ops[i]
      numbers = data.map { |line| line[i] }
      problems << [op, numbers]
    end
    problems.map { |problem| calc(problem) }
            .sum
  end

  def calc(problem)
    op = problem[0]
    if op == '+'
      problem[1].sum
    else
      problem[1].inject(:*)
    end
  end

  def solve2(input)
    ops = input[-1]
    problems = []
    numbers = []
    ops.size.downto(0).each do |i|
      op = ops[i]
      col = column(i, input)
      numbers << col.to_i unless col.strip.empty?
      if ['+', '*'].include?(op)
        problems << [op, numbers]
        numbers = []
      end
    end
    problems.map { |problem| calc(problem) }
            .sum
  end

  def column(column, input)
    input.map { |line| line[column] }
         .join
  end
end
