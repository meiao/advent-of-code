#!/usr/local/bin/ruby

# This program answers Advent of Code 2023 day 02
#
# Author::    Andre Onuki
# License::   GPL3
class Solver
  def solve(input)
    ball_count = {
      'red' => 12,
      'green' => 13,
      'blue' => 14
    }
    sum = 0
    input.each do |line|
      possible = true
      game, data = line.split(':')
      sets = data.split('; ')
      sets.each do |set|
        balls = set.split(', ')
        balls.each do |count_color|
          count, color = count_color.split(' ')
          if count.to_i > ball_count[color]
            possible = false
            break
          end
        end
        break unless possible
      end
      sum += game.split(' ')[1].to_i if possible
    end
    sum
  end

  def solve2(input)
    sum = 0
    input.each do |line|
      min_balls = Hash.new(0)
      _, data = line.split(':')
      sets = data.split('; ')
      sets.each do |set|
        balls = set.split(', ')
        balls.each do |count_color|
          count, color = count_color.split(' ')
          min_balls[color] = count.to_i if count.to_i > min_balls[color]
        end
      end
      sum += min_balls['red'] * min_balls['green'] * min_balls['blue']
    end
    sum
  end
end
