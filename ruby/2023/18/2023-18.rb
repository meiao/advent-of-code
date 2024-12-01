#!/usr/local/bin/ruby

# This program answers Advent of Code 2023 day 18
#
# Author::    Andre Onuki
# License::   GPL3
class Solver
  def solve(input)
    hor_lines = []
    pos = [0, 0]
    range = [0, 0]
    input.each do |line|
      dir, count, = line.split(' ')
      count = count.to_i
      if dir == 'U'
        pos[1] -= count
      elsif dir == 'D'
        pos[1] += count
      elsif dir == 'R'
        hor_lines << [pos[0], pos[0] + count, pos[1]]
        pos[0] += count
      else
        hor_lines << [pos[0] - count, pos[0], pos[1]]
        pos[0] -= count
      end
      range[0] = pos[0] if pos[0] < range[0]
      range[1] = pos[0] if pos[0] > range[1]
    end

    hor_lines.sort_by! { |line| line[2] }

    sum = 0
    (range[0]..range[1]).each do |x|
      lines = hor_lines.select { |line| line[0] <= x && x <= line[1] }
      until lines.empty?
        top_line = lines.shift
        if top_line[0] != x && top_line[1] != x
          discard_top_middle(lines, x)
          bottom_line = lines.shift
          sum += bottom_line[2] - top_line[2] + 1
        elsif (top_line[0] == x && lines[0][0] == x) || (top_line[1] == x && lines[0][1] == x)
          next_line = lines.shift
          sum += next_line[2] - top_line[2] + 1
        else
          lines.shift
          discard_top_middle(lines, x)
          bottom_line = lines.shift
          sum += bottom_line[2] - top_line[2] + 1
        end
      end
    end

    sum
  end

  # this is called from when x is in the middle of the top line
  # at this point, both lines from a C can be discarded, as well as the first line of a S
  def discard_top_middle(lines, x)
    while true
      return if lines[0][0] != x && lines[0][1] != x

      top = lines.shift
      return if (top[0] == x && lines[0][1] == x) || (top[1] == x && lines[0][0] == x) # S

      lines.shift # this was a C
    end
  end

  def solve2(input)
    modified_input = input.map { |line| convert(line) }
    solve(modified_input)
  end

  @@n_dir = {
    '0' => 'R',
    '1' => 'D',
    '2' => 'L',
    '3' => 'U'
  }

  def convert(line)
    color = line.strip.split('#')[1][0..-2]
    size = color[0..4].to_i(16)
    dir = @@n_dir[color[-1]]
    "#{dir} #{size} (#1234)"
  end
end
