#!/usr/local/bin/ruby

# This program answers Advent of Code 2022 day 12
#
# This version ran in
#
# Author::    Andre Onuki
# License::   GPL3
class Solver

  def solve(input)
    @directions = [
      [0, 1],
      [0, -1],
      [-1, 0],
      [1, 0]
    ]
    @map = Map.new(input)
    @visited = {@map.start_pos => true}
    queue = [State.new(@map.start_pos, 0)]
    loop do
      cur_state = queue.shift
      next_positions = process(cur_state)
      return cur_state.steps + 1 if next_positions.include?(@map.end_pos)
      next_positions.each do |pos|
        queue << State.new(pos, cur_state.steps + 1)
        @visited[pos] = true
      end
    end
  end

  def solve2(input)
    @directions = [
      [0, 1],
      [0, -1],
      [-1, 0],
      [1, 0]
    ]
    @map = Map.new(input)
    @visited = {@map.start_pos => true}
    queue = [State.new(@map.end_pos, 0)]
    loop do
      cur_state = queue.shift
      next_positions = process2(cur_state)
      return cur_state.steps + 1 if next_positions.map{|pos| @map.height(pos)}.any?{|height| height == 0}
      next_positions.each do |pos|
        queue << State.new(pos, cur_state.steps + 1)
        @visited[pos] = true
      end
    end
  end

  def process(state)
    pos = state.pos
    new_pos = []
    @directions.each do |dir|
      next_pos = Array.new(pos)
      next_pos[0] += dir[0]
      next_pos[1] += dir[1]
      next if @visited.has_key?(next_pos)
      next unless @map.valid?(next_pos)
      next if @map.height(next_pos) > @map.height(pos) + 1
      new_pos << next_pos
    end
    new_pos
  end

  def process2(state)
    pos = state.pos
    new_pos = []
    @directions.each do |dir|
      next_pos = Array.new(pos)
      next_pos[0] += dir[0]
      next_pos[1] += dir[1]
      next if @visited.has_key?(next_pos)
      next unless @map.valid?(next_pos)
      next if @map.height(next_pos) < @map.height(pos) -1
      new_pos << next_pos
    end
    new_pos
  end
end


class Map
  attr_reader :start_pos, :end_pos
  def initialize(data)
    a_ord = 'a'.ord
    @map = []
    data.each_with_index do |line, row|
      index_s = line.index('S')
      if index_s != nil
        @start_pos = [index_s, row]
        line[index_s] = 'a'
      end
      index_e  = line.index('E')
      if index_e != nil
        @end_pos = [index_e, row]
        line[index_e] = 'z'
      end
      @map << line.strip.chars.map{|c| c.ord - a_ord}
    end
  end

  def valid?(pos)
    return false if pos[0] < 0 || pos[1] < 0
    return false if pos[0] >= @map[0].size
    return false if pos[1] >= @map.size
    true
  end

  def height(pos)
    @map[pos[1]][pos[0]]
  end
end

class State
  attr_reader :pos, :steps
  def initialize(pos, steps)
    @pos = pos
    @steps = steps
  end
end
