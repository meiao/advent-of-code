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
    @map = Hash.new(0)
    @map[0] = 127
    @highest = 0
  end

  def solve(rock_count)
    rock_count.times do |i|
      puts "#{i} #{@highest}" if i % 1000000 == 0
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
        if rock_highest > @highest
          @highest = rock_highest
        end
        rock.stop(@map)
        return
      end
    end
  end

  def print_map
    @highest.downto(0) do |y|
      line = '|'
      line << @map[y].to_s(2).rjust(7,'0').tr('01', '.#')
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
    if @i == @commands.size - 1
      @i = -1
      puts "JetStream reset"
    end
    @i += 1
    @commands[@i]
  end
end

class RockFactory
  ROCKS = [
    [30],
    [8, 28, 8],
    [28, 4, 4],
    [16, 16, 16, 16],
    [24, 24]
  ]
  def initialize
    @i = -1
  end

  def get_next(row)
    @i = -1 if @i == ROCKS.size - 1
    @i += 1
    points = []
    j = 0
    ROCKS[@i].each do |line|
      points << [line, row + j]
      j += 1
    end
    Rock.new(points)
  end
end

class Rock
  BOUNDARY_CHECK = {
    '<' => 64,
    '>' => 1,
    'V' => 0
  }

  def initialize(points)
    @points = points
  end

  def move(direction, map)
    if direction == '<' || direction == '>'
      return false if @points.any?{|p| p[0] & BOUNDARY_CHECK[direction] != 0}
    end

    next_points = do_move(direction)

    return false if next_points.any?{|p| p[0] & map[p[1]] != 0}

    @points = next_points
    true
  end

  def do_move(direction)
    if direction == 'V'
      return @points.map{|p| [p[0], p[1] - 1]}
    elsif direction == '>'
      return @points.map{|p| [p[0] >> 1, p[1]]}
    else
      return @points.map{|p| [p[0] << 1, p[1]]}
    end
  end

  def stop(map)
    @points.each do |p|
      map[p[1]] |= p[0]
    end
  end

  def highest
    @points.map{|p| p[1]}.max
  end
end

class Solver2
  def solve
  end
end
