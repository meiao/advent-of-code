#!/usr/local/bin/ruby

# This program answers Advent of Code 2022 day 11
#
# This version ran in
#
# Author::    Andre Onuki
# License::   GPL3
class Solver
  def solve(input, rounds, worry_divisor)
    monkeys = []
    loop do
      break if input.empty?
      monkeys << Monkey.new(input.shift(6), worry_divisor)
      input.shift # removes blank line
    end
    modulo = monkeys.map{|m| m.divisor}.reduce(1){|a,b| a*b}
    monkeys.each do |monkey|
      monkey.modulo = modulo
    end
    rounds.times do |i|
      monkeys.each do |monkey|
        monkey.throw_items(monkeys)
      end
    end
    monkeys.map{|m| m.inspected}.max(2).reduce(1) {|a, b| a  * b}
  end
end

class Monkey
  attr_reader :inspected, :divisor
  attr_writer :modulo
  def initialize(data, worry_divisor)
    data.shift # remove monkey number
    @items = data.shift.strip.split(': ')[1].split(', ').map{|n| n.to_i}
    @operation = eval("lambda {|old|" + data.shift.strip.split('= ')[1] + "}")
    @divisor = data.shift.strip.split('by ')[1].to_i
    @true_monkey = data.shift.strip.split('monkey ')[1].to_i
    @false_monkey = data.shift.strip.split('monkey ')[1].to_i
    @inspected = 0
    @worry_divisor = worry_divisor
  end

  def throw_items(monkeys)
    @inspected += @items.size
    until @items.empty?
      throw_item(monkeys)
    end
  end

  def throw_item(monkeys)
    item = (@operation.call(@items.shift) / @worry_divisor) % @modulo
    if item % @divisor == 0
      monkeys[@true_monkey] << item
    else
      monkeys[@false_monkey] << item
    end
  end

  def <<(item)
    @items << item
  end
end
