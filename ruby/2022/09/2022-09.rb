#!/usr/local/bin/ruby

# This program answers Advent of Code 2022 day 09
#
# This version ran in
#
# Author::    Andre Onuki
# License::   GPL3
class Solver
  def solve(input, knot_count)
    @knots = []
    knot_count.times {@knots << [0,0]}
    @visited = {}

    input.each do |line|
      direction, count = line.strip.split(' ')
      count.to_i.times do
        move_head(direction)
        (1..(knot_count - 1)).each do |i|
          move_knot(i)
        end
        mark_visited
      end
    end
    @visited.size
  end

  def move_head(direction)
    head = @knots[0]
    case direction
    when 'U'
      head[1] += 1
    when 'D'
      head[1] -= 1
    when 'L'
      head[0] -= 1
    when 'R'
      head[0] += 1
    end
  end

  def move_knot(i)
    knot = @knots[i]
    previous = @knots[i-1]
    dist = knot_distance(knot, previous)
    return if dist < 2
    if dist == 2 || dist == 4
      return if (previous[0] - knot[0]).abs == 1

      knot[0] = (previous[0] + knot[0]) / 2
      knot[1] = (previous[1] + knot[1]) / 2
    else
      if (previous[0] - knot[0]).abs == 1
        knot[0] = previous[0]
        knot[1] = (previous[1] + knot[1]) / 2
      else
        knot[0] = (previous[0] + knot[0]) / 2
        knot[1] = previous[1]
      end
    end
  end

  def knot_distance(knot, previous)
    return (previous[0] - knot[0]).abs + (previous[1] - knot[1]).abs
  end

  def mark_visited
    @visited[Array.new(@knots[-1])] = true
  end



end
