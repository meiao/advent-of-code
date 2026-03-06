#!/usr/local/bin/ruby

require_relative('../../util/hashgrid')
# This program answers Advent of Code 2021 day 25
#
# Author::    Andre Onuki
# License::   GPL3
class Solver
  def solve(input)
    map = HashGrid.new(input, '.')
    steps = 0
    loop do
      steps += 1
      p steps
      moves = do_step(map, '>', [1, 0])
      moves += do_step(map, 'v', [0, 1])
      break if moves == 0
    end
    steps
  end

  def do_step(map, dir, incr)
    movers = find_movers(map, dir, incr)
    move_movers(movers, map, incr)
    movers.size
  end

  def find_movers(map, dir, incr)
    map.select do |pos, v|
      if v == dir
        pos2 = next_pos(map, pos, incr)
        map[pos2] == '.'
      else
        false
      end
    end
  end

  # it is expected that the movers are able to move
  def move_movers(movers, map, incr)
    movers.each do |pos, v|
      map.delete(pos)
      pos2 = next_pos(map, pos, incr)
      map[pos2] = v
    end
  end

  # get the position adding the incr if in bounds
  # get the first cell of the same row/column otherwise
  def next_pos(map, pos, incr)
    next_pos = [pos[0] + incr[0], pos[1] + incr[1]]
    if map.in_bound?(next_pos)
      next_pos
    else
      # reverse multiplying pos and incr will get the first cell of the same row/column
      [pos[0] * incr[1], pos[1] * incr[0]]
    end
  end
end
