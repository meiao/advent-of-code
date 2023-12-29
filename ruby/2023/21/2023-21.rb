#!/usr/local/bin/ruby

# This program answers Advent of Code 2023 day 21
#
# Author::    Andre Onuki
# License::   GPL3
class Solver
  def solve(steps)
    positions = [@origin]
    while steps > 0
      p steps
      next_positions = {}
      steps -= 1
      positions.each do |pos|
        [[0, 1], [0, -1], [1, 0], [-1, 0]].each do |inc|
          next_pos = [pos[0] + inc[0], pos[1] + inc[1]]
          next_positions[next_pos] = true if @map[next_pos] == '.'
        end
      end
      positions = next_positions.keys
    end
    positions.size
  end

  def initialize(input)
    @map = Hash.new('#')
    input.each_with_index do |line, y|
      line.split('').each_with_index do |c, x|
        @map[[x,y]] = '.' if c == '.'
        if c == 'S'
          @origin = [x,y]
          @map[[x,y]] = '.'
        end
      end
    end
    @mod_y = input.size
    @mod_x = input[0].strip.size
  end

  def solve2(steps)
    positions = {@origin => {@origin => true}}
    while steps > 0
      p steps
      next_positions = Hash.new {|h, k| h[k] = {}}
      steps -= 1
      positions.each do |pos, all|
        [[0, 1], [0, -1], [1, 0], [-1, 0]].each do |inc|
          next_pos = [(pos[0] + inc[0]) % @mod_x, (pos[1] + inc[1]) % @mod_y]
          if @map[next_pos] == '.'
            all.keys.each do |p|
              p2 = [p[0] + inc[0], p[1] + inc[1]]
              next_positions[next_pos][p2] = true
            end
          end
        end
      end
      positions = next_positions
      p positions.values.map{|map| map.keys.size}.sum
    end
    positions.values.map{|map| map.keys.size}.sum
  end
end
