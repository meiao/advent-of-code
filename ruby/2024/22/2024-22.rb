#!/usr/local/bin/ruby

# This program answers Advent of Code 2024 day 22
#
# Author::    Andre Onuki
# License::   GPL3
class Solver
  def solve(input)
    input.map(&:to_i)
         .map { |num| evolve(num, 2000) }
         .sum
  end

  def evolve(num, times)
    times.times do
      num = evolve_once(num)
    end
    num
  end

  def evolve_once(num)
    next_num = (num ^ (num << 6)) % 16_777_216
    next_num = (next_num ^ (next_num >> 5)) % 16_777_216
    (next_num ^ (next_num << 11)) % 16_777_216
  end

  def solve2(input)
    monkey_prices = input.map(&:to_i)
                         .map { |num| prices(num, 2000) }
    earnings = Hash.new(0)
    monkey_prices.each_with_index do |prices, _monkey|
      seen_instruction = Hash.new(false)
      instructions = [nil]
      (1..3).each do |i|
        instructions << prices[i] - prices[i - 1]
      end
      (4..(prices.size - 1)).each do |i|
        instructions << prices[i] - prices[i - 1]
        instructions.shift
        instr = instructions.clone
        unless seen_instruction[instr]
          earnings[instr] += prices[i]
          seen_instruction[instr] = true
        end
      end
    end
    earnings.values.max
  end

  def prices(num, times)
    prices = [num % 10]
    times.times do
      num = evolve_once(num)
      prices << num % 10
    end
    prices
  end
end
