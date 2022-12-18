#!/usr/local/bin/ruby

# This program answers Advent of Code 2022 day 17
#
# This version ran in
#
# Author::    Andre Onuki
# License::   GPL3
class Solver


  def initialize(input)
    @rock_factory = RockFactory.new
    @jet_stream = JetStream.new(input)
    @map = Hash.new('.')
    (0..6).each {|x| @map[[x, 0]] = '-'}
    @highest = 0
  end

  def solve(rock_count)
    rock_count.times do |i|
      puts "#{i} #{@highest}" if i % 100000 == 0
      drop_rock
    end
    print_map
    @highest
  end

  def drop_rock
    rock = @rock_factory.get_next(@highest + 4)
    loop do
      rock.move(@jet_stream.get_next, @map)
      if !rock.move('V', @map)
        rock_highest = rock.highest
        @highest = rock_highest if rock_highest > @highest
        rock.stop(@map)
        return
      end
    end
  end

  def print_map
    @highest.downto(0) do |y|
      line = '|'
      (0..6).each {|x| line << @map[[x,y]]}
      line << '|'
      puts line
    end
  end
end

class JetStream
  def initialize(line)
    @commands = line
    @i = -1
  end

  def get_next
    @i = -1 if @i == @commands.size - 1
    @i += 1
    @commands[@i]
  end
end

class RockFactory
  ROCKS = [
    [[2, 0], [3, 0], [4, 0], [5, 0]],
    [[3, 2], [2, 1], [3, 1], [4, 1], [3, 0]],
    [[4, 2], [4, 1], [2, 0], [3, 0], [4, 0]],
    [[2, 3], [2, 2], [2, 1], [2, 0]],
    [[2, 1], [3, 1], [2, 0], [3, 0]]
  ]
  def initialize
    @i = -1
  end

  def get_next(row)
    @i = -1 if @i == ROCKS.size - 1
    @i += 1
    points = ROCKS[@i].map{|point| [point[0], point[1] + row]}
    Rock.new(points)
  end
end

class Rock
  DIR = {
    '<' => [-1, 0],
    '>' => [1, 0],
    'V' => [0, -1]
  }

  def initialize(points)
    @points = points
  end

  def move(direction, map)
    dir = DIR[direction]
    new_points = @points.map{|p| [p[0] + dir[0], p[1] + dir[1]]}
    return false if new_points.any?{|p| map.has_key?(p)}
    if direction != 'V'
      return false if new_points.any?{|p| p[0] < 0 || p[0] > 6}
    end
    @points = new_points
    true
  end

  def stop(map)
    @points.each{|p| map[p] = '#'}

  end

  def highest
    @points.map{|p| p[1]}.max
  end
end

class Solver2
  def solve
  end
end
