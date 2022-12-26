#!/usr/local/bin/ruby

# This program answers Advent of Code 2022 day 23
#
# This version ran in
#
# Author::    Andre Onuki
# License::   GPL3
class Solver
  def initialize(input)
    @move_rules = MoveRule.new
    @elves = []
    input.each_with_index do |line, y|
      line.chars.each_with_index do |c, x|
        @elves << Elf.new([x, y], @move_rules.rules) if c == '#'
      end
    end
  end

  def solve(turns)
    turns.times do
      map = {}
      next_positions = Hash.new(0)
      @elves.each {|elf| map[elf.position] = true}
      @elves.each do |elf|
        elf.calc_next(map)
        next_positions[elf.next_position] += 1 if elf.next_position != nil
      end
      @elves.each do |elf|
        elf.move_unless(next_positions)
      end
      @move_rules.roll
    end
    east = @elves.map{|elf| elf.position[0]}.min
    west = @elves.map{|elf| elf.position[0]}.max
    north = @elves.map{|elf| elf.position[1]}.min
    south = @elves.map{|elf| elf.position[1]}.max
    return (west - east + 1) * (south - north + 1) - @elves.size
  end

  def solve2
    turn = 0
    loop do
      turn += 1
      map = {}
      next_positions = Hash.new(0)
      @elves.each {|elf| map[elf.position] = true}
      @elves.each do |elf|
        elf.calc_next(map)
        next_positions[elf.next_position] += 1 if elf.next_position != nil
      end
      break if next_positions.empty?
      @elves.each do |elf|
        elf.move_unless(next_positions)
      end
      @move_rules.roll
    end
    turn
  end

end

class Elf
  @@NEIGHBORS = {
    [-1, -1] => [:N, :W], [0, -1] => [:N], [1, -1] => [:N, :E],
    [-1,  0] => [:W]    ,                  [1,  0] => [:E]    ,
    [-1,  1] => [:S, :W], [0,  1] => [:S], [1,  1] => [:S, :E]
  }

  attr_reader :position, :next_position
  def initialize(position, move_rules)
    @position = position
    @move_rules = move_rules
  end

  def calc_next(map)
    neighbors = calculate_neighbors(map)
    if neighbors.empty? || neighbors.size == 4
      @next_position = nil
      return
    end

    @move_rules.each do |rule|
      if !rule[0].(neighbors)
        dir = rule[1]
        return @next_position = [@position[0] + dir[0], @position[1] + dir[1]]
      end
    end
    throw Exception.new('neighbors was not empty, but did not match any rule')
  end

  def calculate_neighbors(map)
    cards = Hash.new(false)
    @@NEIGHBORS.each do |dir, card_points|
      if map[[@position[0] + dir[0], @position[1] + dir[1]]] != nil
        card_points.each {|cp| cards[cp] = true}
      end
    end
    cards
  end

  def move_unless(map)
    @position = @next_position if map[@next_position] == 1
  end
end

class MoveRule
  attr_reader :rules
  def initialize
    @rules = [
      [->(neighbors) {neighbors[:N]}, [ 0, -1]], #N
      [->(neighbors) {neighbors[:S]}, [ 0,  1]], #S
      [->(neighbors) {neighbors[:W]}, [-1,  0]], #W
      [->(neighbors) {neighbors[:E]}, [ 1,  0]]  #E
    ]
  end

  def roll
    @rules << @rules.shift
  end
end

class Solver2
  def solve
  end
end
