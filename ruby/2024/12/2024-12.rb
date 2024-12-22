#!/usr/local/bin/ruby

# This program answers Advent of Code 2024 day 12
#
# Author::    Andre Onuki
# License::   GPL3
require_relative('../../util/hashgrid')

class Solver
  def solve(input)
    grid = HashGrid.new(input)

    keys = grid.keys
    keys.map { |pos| calc(pos, grid) }
        .sum
  end

  def calc(pos, grid)
    char = grid[pos]
    return 0 if char.nil?

    perimeter = 0
    stack = [pos]
    grid.delete(pos)
    visited = Hash.new(false)
    visited[pos] = true
    until stack.empty?
      cur_pos = stack.pop
      perimeter += 4
      [[0, 1], [0, -1], [1, 0], [-1, 0]].each do |dir|
        next_pos = [cur_pos[0] + dir[0], cur_pos[1] + dir[1]]
        if visited[next_pos]
          perimeter -= 1
        elsif grid[next_pos] == char
          perimeter -= 1
          grid.delete(next_pos)
          stack << next_pos
          visited[next_pos] = true
        end
      end
    end
    visited.size * perimeter
  end

  def solve2(input)
    grid = HashGrid.new(input)

    keys = grid.keys
    keys.map { |pos| blocks(pos, grid) }
        .compact
        .map { |block| calc2(block) }
        .sum
  end

  def blocks(pos, grid)
    char = grid[pos]
    return nil if char.nil?

    stack = [pos]
    grid.delete(pos)
    visited = Hash.new(false)
    visited[pos] = true
    until stack.empty?
      cur_pos = stack.pop
      [[0, 1], [0, -1], [1, 0], [-1, 0]].each do |dir|
        next_pos = [cur_pos[0] + dir[0], cur_pos[1] + dir[1]]
        next unless grid[next_pos] == char

        grid.delete(next_pos)
        stack << next_pos
        visited[next_pos] = true
      end
    end
    visited
  end

  def calc2(block)
    columns = Hash.new { |h, k| h[k] = [] }
    rows = Hash.new { |h, k| h[k] = [] }
    block.keys.each do |pos|
      columns[pos[0]] << pos[1]
      rows[pos[1]] << pos[0]
    end
    columns.values.each(&:sort!)
    rows.values.each(&:sort!)
    left = vertical_walls(columns, block, -1)
    right = vertical_walls(columns, block, 1)
    upper = horizontal_walls(rows, block, -1)
    lower = horizontal_walls(rows, block, 1)
    block.size * (left + right + upper + lower)
  end

  def vertical_walls(columns, blocks, covered_dir)
    walls = 0
    columns.each do |x, rows|
      previous_row = -2 # makes sure that 0 would not be adjacent
      previous_covered = true # if the first row is uncovered, it should add a wall
      rows.each do |y|
        adjacent = previous_row == y - 1
        covered = blocks[[x + covered_dir, y]]
        walls += 1 if !covered && (previous_covered || !adjacent)
        previous_covered = covered
        previous_row = y
      end
    end
    walls
  end

  def horizontal_walls(rows, blocks, covered_dir)
    walls = 0
    rows.each do |y, cols|
      previous_col = -2 # makes sure that 0 would not be adjacent
      previous_covered = true # if the first row is uncovered, it should add a wall
      cols.each do |x|
        adjacent = previous_col == x - 1
        covered = blocks[[x, y + covered_dir]]
        walls += 1 if !covered && (previous_covered || !adjacent)
        previous_covered = covered
        previous_col = x
      end
    end
    walls
  end

end
