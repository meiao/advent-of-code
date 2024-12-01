#!/usr/local/bin/ruby

# This program answers Advent of Code 2022 day 10
#
# This version ran in
#
# Author::    Andre Onuki
# License::   GPL3
class Solver
  def solve(input, interesting)
    x = 1
    cycle = 1
    sum = 0
    input.each do |cmd|
      if interesting[0] == cycle
        sum += x * cycle
        interesting.shift
      end

      if cmd.strip == 'noop'
        cycle += 1
      else
        if interesting[0] == cycle + 1
          sum += x * (cycle + 1)
          interesting.shift
        end

        cycle += 2
        x += cmd.strip.split(' ')[1].to_i
      end
    end
    sum
  end
end

class Solver2
  def solve(input)
    x = 1
    cycle = 1
    screen = ''
    input.each do |cmd|
      screen << pixel(cycle, x)
      if cmd.strip == 'noop'
        cycle += 1
      else
        screen << pixel(cycle + 1, x)
        cycle += 2
        x += cmd.strip.split(' ')[1].to_i
      end
    end
    screen
  end

  def pixel(cycle, x)
    # something wonky here, edges do not work properly due to modulo wrapping around
    return '#' if x >= (cycle % 40) - 2 && x <= cycle % 40

    '.'
  end
end
