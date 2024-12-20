#!/usr/local/bin/ruby

# This program answers Advent of Code 2024 day 20
#
# Author::    Andre Onuki
# License::   GPL3
require_relative '../../util/grid'
class Solver
  def solve(input, cheat_time, min_steps_saved)
    path = find_path(input)
    cheat_positions = make_cheat_positions(cheat_time)
    Hash.new(0)
    path.map { |pos, step| find_cheats(pos, step, cheat_positions, path) }
        .flatten(1)
        .map { |cheat| cheat[1] - cheat[0] - cheat[2] }
        .filter { |steps_saved| steps_saved >= min_steps_saved }
        .size
  end

  def find_path(input)
    grid = Grid.new(input)
    pos = Finder.new(grid).find_single_char('S')[0][0]
    path = Hash.new(-1)
    path[pos] = 0
    dirs = [[1, 0], [0, 1], [-1, 0], [0, -1]]
    until grid[pos] == 'E'
      dirs.map { |dir| posdir(pos, dir) }
          .each do |next_pos|
        if (grid[next_pos] == '.' || grid[next_pos] == 'E') && path[next_pos] == -1
          path[next_pos] = path[pos] + 1
          pos = next_pos
        end
      end
    end
    path
  end

  # returns an array of arrays.
  # the second level arrays contain:
  # [0] the step where the cheat starts,
  # [1] the step where the cheat ends
  # [2] the distance travelled to cheat
  def find_cheats(pos, step, cheat_positions, path)
    cheat_positions.map { |dir| [posdir(pos, dir), dir[0].abs + dir[1].abs] }
                   .filter { |next_pos, dist| path[next_pos] > step + dist }
                   .map { |next_pos, dist| [step, path[next_pos], dist] }
  end

  def posdir(pos, dir)
    [pos[0] + dir[0], pos[1] + dir[1]]
  end

  # Creates an array with all the possible coordinates
  # that could be travelled (from [0,0]) in the amount of time.
  def make_cheat_positions(time)
    cheat_positions = []
    ((-time)..time).each do |x|
      ((-time + x.abs)..(time - x.abs)).each do |y|
        cheat_positions << [x, y] if x.abs + y.abs > 1
      end
    end
    cheat_positions
  end
end
