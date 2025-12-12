#!/usr/local/bin/ruby

# This program answers Advent of Code 2025 day 08
#
# Author::    Andre Onuki
# License::   GPL3
class Solver
  def solve(input, count)
    boxes = boxes(input)
    connections = connections(boxes)
    circuits = Array.new(boxes.size) { |i| i }
    while count > 0
      connection = connections.shift
      c0 = circuits[connection[0]]
      c1 = circuits[connection[1]]
      circuits.map! { |v| v == c1 ? c0 : v } unless c0 == c1
      count -= 1
    end
    circuits.tally.values.sort[-3..].inject(&:*)
  end

  def boxes(input)
    input.map { |line| line.split(',').map(&:to_i) }
  end

  # returns an array with all possible connections, sorted by distance
  def connections(boxes)
    connections = []
    0.upto(boxes.size - 2).each do |i|
      (i + 1).upto(boxes.size - 1).each do |j|
        dist = distance(boxes[i], boxes[j])
        connections << [dist, [i, j]]
      end
    end

    connections.sort.map { |connection| connection[1] }
  end

  def distance(b1, b2)
    (b1[0] - b2[0])**2 + (b1[1] - b2[1])**2 + (b1[2] - b2[2])**2
  end

  def solve2(input)
    boxes = boxes(input)
    connections = connections(boxes)
    circuits = Array.new(boxes.size) { |i| i }
    loop do
      connection = connections.shift
      c0 = circuits[connection[0]]
      c1 = circuits[connection[1]]
      circuits.map! { |v| v == c1 ? c0 : v }
      return boxes[connection[0]][0] * boxes[connection[1]][0] if circuits.tally.size == 1
    end
  end
end
