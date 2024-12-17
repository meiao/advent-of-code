#!/usr/local/bin/ruby

# This program answers Advent of Code 2024 day 16
#
# Author::    Andre Onuki
# License::   GPL3

require_relative('../../util/hashgrid')

class Solver
  def initialize(input)
    @map = HashGrid.new(input, '.')
    @end = @map.find('E')
    @dirs = [[1, 0], [0, 1], [-1, 0], [0, -1]]
  end

  def solve
    @best = 200_000
    @status_best = Hash.new(@best)
    status = @map.find('S')
    status << 0
    do_solve(status, 0)
  end

  def do_solve(status, cost)
    pos = status[0, 2]
    return @best if @map[pos] == '#'

    if pos == @end
      @best = cost if cost < @best
      return @best
    end
    return @best if cost > @best
    return @best if @status_best[status] <= cost

    @status_best[status] = cost
    results = []
    dir = @dirs[status[2]]
    step_status = [status[0] + dir[0], status[1] + dir[1], status[2]]
    results << do_solve(step_status, cost + 1)
    results << do_solve([status[0], status[1], (status[2] + 1) % 4], cost + 1000)
    results << do_solve([status[0], status[1], (status[2] - 1) % 4], cost + 1000)
    results.min
  end

  def solve2(best)
    @best = best
    @status_best = Hash.new(@best)
    @in_best_path = {}
    status = @map.find('S')
    status << 0
    do_solve2(status, 0)
    @in_best_path.size
  end

  def do_solve2(status, cost)
    pos = status[0, 2]
    if pos == @end
      @in_best_path[pos] = 'O'
      return true
    end
    return false if cost > @best
    return false if @status_best[status] < cost
    return false if @map[pos] == '#'

    @status_best[status] = cost

    dir = @dirs[status[2]]
    step_status = [status[0] + dir[0], status[1] + dir[1], status[2]]
    in_best_path = do_solve2(step_status, cost + 1)
    in_best_path = do_solve2([status[0], status[1], (status[2] + 1) % 4], cost + 1000) || in_best_path
    in_best_path = do_solve2([status[0], status[1], (status[2] - 1) % 4], cost + 1000) || in_best_path
    if in_best_path
      @in_best_path[pos] = 'O'
      return true
    end
    return false
  end
end
