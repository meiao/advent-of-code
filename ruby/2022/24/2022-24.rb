#!/usr/local/bin/ruby

# This program answers Advent of Code 2022 day 24
#
# This version ran in
#
# Author::    Andre Onuki
# License::   GPL3
class Solver
  def initialize(input)
    @width = input[0].length - 3
    @height = input.size - 2
    @wh = @width * @height
    @visited_states = Hash.new(false)
    @map = {}
    input.each_with_index do |line, y|
      line.strip.chars.each_with_index do |char, x|
        @map[[x, y]] = if char == '#'
                         BlockedPosition.instance
                       else
                         Position.new
                       end
      end
    end

    # Map must be fully processed before this loop can run
    # rubocop:disable Style/CombinableLoops
    input.each_with_index do |line, y|
      line.strip.chars.each_with_index do |char, x|
        coord = [x, y]
        if char == '>'
          process_horizontal(coord, 1, 1)
        elsif char == '<'
          process_horizontal(coord, -1, @width)
        elsif char == '^'
          process_vertical(coord, -1, @height)
        elsif char == 'v'
          process_vertical(coord, 1, 1)
        end
      end
      # rubocop:enable Style/CombinableLoops
    end
    @map[[1, -1]] = BlockedPosition.instance
    @map[[@width, @height + 2]] = BlockedPosition.instance
  end

  def process_horizontal(coord, increment, reset_to)
    @width.times do |i|
      @map[coord].add_horizontal(i)
      coord[0] += increment
      coord[0] = reset_to if @map[coord].is_a? BlockedPosition
    end
  end

  def process_vertical(coord, increment, reset_to)
    @width.times do |i|
      @map[coord].add_vertical(i)
      coord[1] += increment
      coord[1] = reset_to if @map[coord].is_a? BlockedPosition
    end
  end

  def solve
    do_solve([State.new([1, 0], 0, nil)], [@width, @height + 1])
  end

  def solve2(arrive_at_final)
    start = [1, 0]
    final = [@width, @height + 1]
    arrive_at_beginning = do_solve([State.new(final, arrive_at_final, nil)], start)
    @visited_states = Hash.new(false)
    do_solve([State.new(start, arrive_at_beginning, nil)], final)
  end

  def do_solve(queue, goal)
    loop do
      state = queue.shift
      @@moves.each do |move|
        pos = state.position
        time = state.time
        next_position = [pos[0] + move[0], pos[1] + move[1]]
        print_path(state) if next_position == goal
        return time if next_position == goal

        next unless @map[next_position].clear_at?(time % @width, time % @height)

        key = [next_position, time % @wh]
        unless @visited_states[key]
          queue << State.new(next_position, time + 1, state)
          @visited_states[key] = true
        end
      end
    end
  end

  def print_path(state)
    print_path(state.parent) unless state.parent.nil?
    time = state.time - 1
    (@height + 2).times do |y|
      line = ''
      (@width + 2).times do |x|
        coord = [x, y]
        line << if state.position == coord
                  'E'
                elsif @map[coord].is_a? BlockedPosition
                  '#'
                elsif @map[coord].clear_at?(time % @width, time % @height)
                  '.'
                else
                  'X'
                end
      end
    end
  end

  @@moves = [
    [0, 1],
    [1, 0],
    [0, 0],
    [-1, 0],
    [0, -1]
  ]
end

class State
  attr_reader :position, :time, :parent

  def initialize(position, time, parent)
    @position = position
    @time = time
    @parent = parent
  end

  def to_s
    parent.to_s + "#{position} - #{time}\r\n"
  end
end

class Position
  def initialize
    @horizontal_on = Hash.new(false)
    @vertical_on = Hash.new(false)
  end

  def add_horizontal(modulo)
    @horizontal_on[modulo] = true
  end

  def add_vertical(modulo)
    @vertical_on[modulo] = true
  end

  ## times must be in respective modulo
  def clear_at?(horizontal_time, vertical_time)
    !@horizontal_on[horizontal_time] && !@vertical_on[vertical_time]
  end

  def to_s
    "h = #{@horizontal_on.keys.sort}, v = #{@vertical_on.keys.sort}"
  end
end

class BlockedPosition
  @@instance = BlockedPosition.new

  def self.instance = @@instance

  def clear_at?(_horizontal_time, _vertical_time)
    false
  end
end
