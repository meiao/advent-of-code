#!/usr/local/bin/ruby

# This program answers Advent of Code 2022 day 09
#
# This version ran in
#
# Author::    Andre Onuki
# License::   GPL3
class Solver
  def solve(input)
    @h = [0, 0]
    @t = [0, 0]
    @visited = {}

    input.each do |line|
      direction, count = line.strip.split(' ')
      count.to_i.times do
        move_head(direction)
        move_tail
        mark_visited
      end
    end
    @visited.size
  end

  def move_head(direction)
    case direction
    when 'U'
      @h[1] += 1
    when 'D'
      @h[1] -= 1
    when 'L'
      @h[0] -= 1
    when 'R'
      @h[0] += 1
    end
  end

  def move_tail
    dist = ht_distance()
    return if dist < 2
    if dist == 2
      return if (@h[0] - @t[0]).abs == 1

      @t[0] = (@h[0] + @t[0]) / 2
      @t[1] = (@h[1] + @t[1]) / 2
    else
      if (@h[0] - @t[0]).abs == 1
        @t[0] = @h[0]
        @t[1] = (@h[1] + @t[1]) / 2
      else
        @t[0] = (@h[0] + @t[0]) / 2
        @t[1] = @h[1]
      end
    end
  end

  def ht_distance
    return (@h[0] - @t[0]).abs + (@h[1] - @t[1]).abs
  end

  def mark_visited
    @visited[Array.new(@t)] = true
  end



end

class Solver2
  def solve
  end
end
