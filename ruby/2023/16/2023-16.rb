#!/usr/local/bin/ruby

# This program answers Advent of Code 2023 day 16
#
# Author::    Andre Onuki
# License::   GPL3
class Solver
  def solve(input)
    sim = Simulator.new(input)
    sim.calculate([0, 0], :r)
    sim.result
  end

  def solve2(input)
    sim = Simulator.new(input)
    height = input.size
    # -1 to account for "\n"
    width = input[0].size - 1

    start_states = []
    max_x = width - 1
    height.times do |y|
      start_states << [[0, y], :r]
      start_states << [[max_x, y], :l]
    end
    max_y = height - 1
    width.times do |x|
      start_states << [[x, 0], :d]
      start_states << [[x, max_y], :u]
    end

    start_states.map do |state|
      sim.reset
      sim.calculate(state[0], state[1])
      sim.result
    end.max
  end
end

class Simulator
  @@dir = {
    r: [1, 0],
    l: [-1, 0],
    u: [0, -1],
    d: [0, 1]
  }

  def initialize(input)
    @map = Hash.new('*')
    create_map(input)
  end

  def calculate(pos, direction)
    return if @map[pos] == '*'
    return if @active[pos].include? direction

    @active[pos] << direction

    tile = @map[pos]
    if tile == '.' ||
       (tile == '-' && %i[r l].include?(direction)) ||
       (tile == '|' && %i[u d].include?(direction))
      calculate(next_pos(pos, direction), direction)
    elsif tile == '|'
      calculate(next_pos(pos, :u), :u)
      calculate(next_pos(pos, :d), :d)
    elsif tile == '-'
      calculate(next_pos(pos, :l), :l)
      calculate(next_pos(pos, :r), :r)
    elsif (tile == '\\' && direction == :l) || (tile == '/' && direction == :r)
      calculate(next_pos(pos, :u), :u)
    elsif (tile == '\\' && direction == :r) || (tile == '/' && direction == :l)
      calculate(next_pos(pos, :d), :d)
    elsif (tile == '\\' && direction == :u) || (tile == '/' && direction == :d)
      calculate(next_pos(pos, :l), :l)
    elsif (tile == '\\' && direction == :d) || (tile == '/' && direction == :u)
      calculate(next_pos(pos, :r), :r)
    end
  end

  def result
    @active.size
  end

  def reset
    @active = Hash.new { |h, k| h[k] = [] }
  end

  private

  def create_map(input)
    input.each_with_index do |line, y|
      line.strip.split('').each_with_index do |c, x|
        @map[[x, y]] = c
      end
    end
  end

  def next_pos(pos, dir)
    inc = @@dir[dir]
    [pos[0] + inc[0], pos[1] + inc[1]]
  end
end
