#!/usr/local/bin/ruby

# This program answers Advent of Code 2024 day 25
#
# Author::    Andre Onuki
# License::   GPL3
class Solver
  def solve(input)
    items = input.split("\n\n").map { |data| data.split("\n") }
    height = items[0].size - 1
    width = items[0][0].size
    locks = items.filter { |item| item[0][0] == '#' }
                 .map { |lock| make_lock(lock, height, width) }
    keys = items.filter { |item| item[0][0] == '.' }
                .map { |key| make_key(key, height, width) }
    locks.product(keys)
         .filter { |key, lock| fits(lock, key, height) }
         .size
  end

  def make_lock(data, _height, width)
    lock = Array.new(width, 0)
    data[1..].each do |line|
      line.chars.each_with_index do |char, i|
        lock[i] += 1 if char == '#'
      end
    end
    lock
  end

  def make_key(data, height, width)
    key = Array.new(width, height)
    data.each do |line|
      line.chars.each_with_index do |char, i|
        key[i] -= 1 if char == '.'
      end
    end
    key
  end

  def fits(lock, key, height)
    lock.zip(key).map(&:sum).all? { |val| val < height }
  end
end
