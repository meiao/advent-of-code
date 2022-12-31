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
    @heights = [0]
    @reset = [false]
    @reset_rock = []
  end

  def solve(rock_count)
    rock_count.times do |i|
      drop_rock
      if @reset[0]
        @reset[0] = false
        @reset_rock << i
        break if @reset_rock.size == 10
      end
    end

    if @reset_rock.size < 2
      return @heights[-1]
    end

    cycle_length = @reset_rock[1] - @reset_rock[0]
    cycles = (rock_count - @reset_rock[0]) / cycle_length
    remaining = rock_count - @reset_rock[0] - (cycle_length * cycles)
    a= @heights[@reset_rock[0]]
    b= cycles * (@heights[@reset_rock[1]] - @heights[@reset_rock[0]])
    c= @heights[@reset_rock[0] + remaining] - @heights[@reset_rock[0]]
    a+b+c
  end

  def drop_rock
    rock = @rock_factory.get_next(@heights[-1] + 4)
    loop do
      rock.move(@jet_stream.get_next(@reset), @map)
      if !rock.move('V', @map)
        @heights << [rock.highest, @heights[-1]].max
        rock.stop(@map)
        return
      end
    end
  end
end

class JetStream
  def initialize(line)
    @directions = line
    @i = 0
  end

  def get_next(reset)
    direction = @directions[@i]
    @i += 1
    if @i == @directions.size
      @i = 0
      reset[0] = true
    end
    direction
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
