#!/usr/local/bin/ruby

require '../priority_queue'

# This version ran in 9.029220s.
#
# After a couple of attempts using DFS (the 2nd also using dynamic programming),
# this solution uses Djikstra's algorithm.
#
# Author::    Andre Onuki
# License::   GPL3
class Solver
  def initialize(matrix)
    @matrix = matrix
    @directions = [[0, 1], [0, -1], [1, 0], [-1, 0]]
    @lines = matrix.size
    @cols = matrix[0].size
    @queue = PriorityQueue.new
    init_pre_calc
  end

  def init_pre_calc
    @pre_calc = []
    size = @matrix[0].size
    @matrix.size.times { @pre_calc << Array.new(size, 764_386) }
    @lines.times do |line|
      @cols.times do |col|
        @queue.push([line, col], 764_386)
      end
    end
    @pre_calc[0][0] = @matrix[0][0]
    @queue.push([0, 0], @matrix[0][0])
  end

  def solve
    loop do
      node = @queue.min
      return @pre_calc[node[0]][node[1]] - @matrix[0][0] if node[0] == @lines - 1 && node[1] == @cols - 1

      calc_neighbors(node)
    end
  end

  def calc_neighbors(node)
    @directions.map { |dir| apply_dir(node, dir) }
               .filter { |next_node| valid_node?(next_node) }
               .map { |neighbor| update_neighbor(node, neighbor) }
  end

  def apply_dir(node, dir)
    [node[0] + dir[0], node[1] + dir[1]]
  end

  def valid_node?(node)
    line = node[0]
    column = node[1]
    line >= 0 && line < @lines && column >= 0 && column < @cols
  end

  def update_neighbor(node, neighbor)
    value = neighbor_value(node, neighbor)
    return unless value < @pre_calc[neighbor[0]][neighbor[1]]

    @pre_calc[neighbor[0]][neighbor[1]] = value
    @queue.push(neighbor, value)
  end

  def neighbor_value(node, neighbor)
    @pre_calc[node[0]][node[1]] + @matrix[neighbor[0]][neighbor[1]]
  end
end

def read_file(filename)
  matrix = []
  lines = IO.readlines(filename).collect { |l| l.strip }
  lines.each do |line|
    matrix << line.split('').map(&:to_i)
  end
  matrix
end

matrix = read_file('15-input')
@solver = Solver.new(matrix)
p @solver.solve
