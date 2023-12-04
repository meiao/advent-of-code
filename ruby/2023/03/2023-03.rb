#!/usr/local/bin/ruby

# This program answers Advent of Code 2023 day 03
#
# Author::    Andre Onuki
# License::   GPL3
class Solver
  def solve(input)

    @input = input_to_hash(input)

    sum = 0
    input.size.times do |y|
      (input[0].size - 1).times do |x|
        if (@input[[x, y]] =~ /[\d.]/) == nil
          [-1, 0, 1].each do |i|
            [-1, 0, 1].each do |j|
              sum += get_number_at(x + i, y + j)
            end
          end
        end
      end
    end

    sum
  end

  def get_number_at(x, y)
    return 0 if (@input[[x,y]] =~ /\d/) == nil
    while (@input[[x-1, y]] =~ /\d/) != nil
      x -= 1
    end
    num = 0
    while (@input[[x, y]] =~ /\d/) != nil
      num *= 10
      num += @input[[x, y]].to_i
      @input[[x, y]] = '.'
      x += 1
    end
    p num
    num
  end

  def input_to_hash(input)
    hash = Hash.new('.')
    input.size.times do |y|
      (input[0].size - 1).times do |x|
        hash[[x,y]] = input[y][x]
      end
    end
    hash
  end

  def solve2(input)
    @input = input_to_hash(input)

    sum = 0
    input.size.times do |y|
      (input[0].size - 1).times do |x|
        if @input[[x, y]] == '*'
          sum += gear_ratio(x, y)
        end
      end
    end

    sum
  end

  def gear_ratio(x ,y)
    numbers = []
    used = Hash.new(false)
    [-1, 0, 1].each do |i|
      [-1, 0, 1].each do |j|
        next if used[[x+i, y+j]]
        numbers << get_number_at2(x + i, y + j, used)
      end
    end
    numbers.filter! {|n| n != 0}
    return 0 if numbers.size != 2
    return numbers[0] * numbers[1]
  end

  def get_number_at2(x, y, used)
    return 0 if (@input[[x,y]] =~ /\d/) == nil
    while (@input[[x-1, y]] =~ /\d/) != nil
      x -= 1
    end
    num = 0
    while (@input[[x, y]] =~ /\d/) != nil
      num *= 10
      num += @input[[x, y]].to_i
      used[[x, y]] = true
      x += 1
    end
    num
  end
end
