#!/usr/local/bin/ruby

# This program answers Advent of Code 2024 day 18
#
# Author::    Andre Onuki
# License::   GPL3
require_relative('../../util/priority_queue')

class Solver
  def solve(input, byte_count, exit)
    @input = input
    @is_wall = Hash.new(false)
    byte_count.times { |_| add_wall() }
    @exit = exit
    @step_count = Hash.new(1_000_000_000)
    @step_count[[0, 0]] = 0
    min_path([0, 0])
    @step_count[exit]
  end

  def add_wall
    line = @input.shift()
    pos = line.split(',').map(&:to_i)
    @is_wall[pos] = true
    pos
  end

  # uses a dijkstra like algorithm to find the smallest path
  def min_path(initial_pos)
    queue = PriorityQueue.new()
    queue.push(initial_pos, 0)
    until queue.empty?
      pos = queue.min()
      next_step_count = @step_count[pos] + 1
      [[0, 1], [1, 0], [0, -1], [-1, 0]].map { |dir| posdir(pos, dir) }
                                        .filter { |next_pos| valid?(next_pos) }
                                        .filter { |next_pos| good_pos?(next_pos, next_step_count) }
                                        .each do |next_pos|
                                          @step_count[next_pos] = next_step_count
                                          queue.push(next_pos, next_step_count)
                                        end
    end
  end

  def posdir(pos, dir)
    [pos[0] + dir[0], pos[1] + dir[1]]
  end

  def valid?(pos)
    return false if pos[0] < 0 || pos[1] < 0 || pos[0] > @exit[0] || pos[1] > @exit[1]
    return false if @is_wall[pos]

    true
  end

  def good_pos?(pos, next_step_count)
    next_step_count <= @step_count[pos]
  end

  def solve2(input, exit)
    @input = input
    @exit = exit
    @is_wall = Hash.new(false)
    last_wall = add_wall
    @in_path = Hash.new(false)
    # while there is a solution
    while find_path([0, 0])
      # add a wall, until a wall is put on the last path found
      last_wall = add_wall() until @in_path[last_wall]
      @in_path.clear()
    end
    last_wall.to_s[1..-2].tr(' ', '')
  end

  # this find_path uses a dumb dfs to find any solution
  # for part 2, the solution does not need to be optimal.
  def find_path(pos)
    return false if @in_path[pos]

    @in_path[pos] = true
    return true if pos == @exit

    [[0, 1], [1, 0], [0, -1], [-1, 0]].map { |dir| posdir(pos, dir) }
                                      .filter { |next_pos| valid?(next_pos) }
                                      .each do |next_pos|
                                        return true if find_path(next_pos)
                                      end
    @in_path.delete(pos)
    false
  end
end
