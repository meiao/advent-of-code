#!/usr/local/bin/ruby

# This program answers Advent of Code 2023 day 10
#
# Author::    Andre Onuki
# License::   GPL3
class Solver
  @@directions = {
    u: [0, -1],
    d: [0, 1],
    r: [1, 0],
    l: [-1, 0]
  }

  # when in a cell [character, direction], the next direction is going to be
  # the value
  @@converter = {
    ['|', :u] => :u,
    ['|', :d] => :d,
    ['-', :r] => :r,
    ['-', :l] => :l,
    ['L', :d] => :r,
    ['L', :l] => :u,
    ['J', :d] => :l,
    ['J', :r] => :u,
    ['7', :r] => :d,
    ['7', :u] => :l,
    ['F', :l] => :d,
    ['F', :u] => :r
  }

  # when in a cell [character, inside], the inside for the next cell will be
  # the value
  @@next_inside = {
    ['|', :l] => :l,
    ['|', :r] => :r,
    ['-', :u] => :u,
    ['-', :d] => :d,
    ['L', :u] => :r,
    ['L', :d] => :l,
    ['L', :l] => :d,
    ['L', :r] => :u,
    ['J', :u] => :l,
    ['J', :d] => :r,
    ['J', :l] => :u,
    ['J', :r] => :d,
    ['7', :u] => :r,
    ['7', :d] => :l,
    ['7', :l] => :d,
    ['7', :r] => :u,
    ['F', :u] => :l,
    ['F', :d] => :r,
    ['F', :l] => :u,
    ['F', :r] => :d
  }

  # when in a cell with the [character, inside], the value should be marked
  @@marks = {
    ['|', :l] => [:l],
    ['|', :r] => [:r],
    ['-', :u] => [:u],
    ['-', :d] => [:d],
    ['L', :u] => [],
    ['L', :d] => %i[d l],
    ['L', :l] => %i[d l],
    ['L', :r] => [],
    ['J', :u] => [],
    ['J', :d] => %i[r d],
    ['J', :l] => [],
    ['J', :r] => %i[r d],
    ['7', :u] => %i[u r],
    ['7', :d] => [],
    ['7', :l] => [],
    ['7', :r] => %i[u r],
    ['F', :u] => %i[u l],
    ['F', :d] => [],
    ['F', :l] => %i[u l],
    ['F', :r] => []

  }

  def solve(input)
    map, start = make_map(input)
    position, direction = first_step(map, start)
    cycle = calc_cycle(map, position, direction)
    (cycle.size + 1) / 2
  end

  def make_map(input)
    map = {}
    start = nil
    input.each_with_index do |line, y|
      line.strip.split('').each_with_index do |char, x|
        start = [x, y] if char == 'S'
        map[[x, y]] = char
      end
    end
    [map, start]
  end

  def first_step(map, start)
    @@directions.each do |dir, _inc|
      next_position = calc_next_position(start, dir)
      next_char = map[next_position]
      return [next_position, @@converter[[next_char, dir]]] if @@converter[[next_char, dir]] != nil
    end
  end

  def calc_next_position(pos, dir)
    inc = @@directions[dir]
    [pos[0] + inc[0], pos[1] + inc[1]]
  end

  # has a side effect of changing the S to the appropriate character
  def calc_cycle(map, position, direction)
    cycle = Hash.new(false)
    while map[position] != 'S'
      cycle[position] = true
      position = calc_next_position(position, direction)
      direction = @@converter[[map[position], direction]]
    end
    cycle[position] = true

    # since later the cycle is going to be rerun, but from a different
    # start, the S needs to be substituted by the proper character
    above = map[calc_next_position(position, :u)]
    below = map[calc_next_position(position, :d)]
    left = map[calc_next_position(position, :l)]
    map[position] = if ['|', '7', 'F'].include?(above)
                      if ['|', 'L', 'J'].include?(below)
                        '|'
                      elsif ['-', 'L', 'F'].include?(left)
                        'J'
                      else
                        'L'
                      end
                    elsif ['|', 'L', 'J'].include?(below)
                      if ['-', 'L', 'F'].include?(left)
                        '7'
                      else
                        'F'
                      end
                    else
                      '-'
                    end
    cycle
  end

  def solve2(input)
    map, start = make_map(input)
    position, direction = first_step(map, start)
    cycle = calc_cycle(map, position, direction)
    marked = mark(map, cycle)
    marked.size - cycle.size
  end

  # mark all the cells that are either part of the cycle or inside
  def mark(map, cycle)
    # the left most (then top most) cell must be an F
    first_f = cycle.keys.sort[0]
    marked = Hash.new(false)
    marked[first_f] = true
    # since we are using the first F, we can go to the cell right of it
    # and down is the inside direction
    position = [first_f[0] + 1, first_f[1]]
    direction = @@converter[[map[position], :r]]
    inside = @@next_inside[[map[position], :d]]

    # pretty much the same code as the cycle, with the inside added
    # and adding marks both to the cycle and to the inside
    while position != first_f
      marked[position] = true
      cur_char = map[position]
      @@marks[[cur_char, inside]].each do |mark_dir|
        to_mark = calc_next_position(position, mark_dir)
        marked[to_mark] = true
      end
      position = calc_next_position(position, direction)
      direction = @@converter[[map[position], direction]]
      inside = @@next_inside[[map[position], inside]]
    end

    # to get the area that is not adjacent to the cycle, go thru all the marked
    # cells (not in the cycle), and mark any adjacent that has not been marked
    to_check = marked.keys.filter { |pos| !cycle[pos] }

    until to_check.empty?
      position = to_check.pop
      @@directions.keys.each do |dir|
        p = calc_next_position(position, dir)
        unless marked[p]
          marked[p] = true
          to_check << p
        end
      end
    end

    marked
  end
end
