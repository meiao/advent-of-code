#!/usr/local/bin/ruby

# This program answers Advent of Code 2023 day 17
#
# Author::    Andre Onuki
# License::   GPL3

class Solver

  @@dir = [
    [1, 0],
    [0, 1],
    [-1, 0],
    [0, -1]
  ]

  def solve(input)
    map = create_map(input)
    max = map.values.sum
    best = Hash.new {|h, k| h[k] = {1 => max, 2 => max, 3 => max}}
    best[[[0,0], [0,0]]][1] = 0

    target = [input[0].size - 2, input.size - 1]
    queue = PriorityQueue.new
    queue.push([[0,0], [0,0], 1], 0)
    while true
      pair = queue.min
      break if pair == nil
      pos, last_dir, last_count = pair[0]
      next if pos == target
      cur_heat = best[[pos, last_dir]][last_count]
      @@dir.each do |dir|
        next if last_dir == [dir[0] * -1, dir[1] * -1]
        next if dir == last_dir && last_count == 3

        next_pos = [pos[0] + dir[0], pos[1] + dir[1]]
        next_heat = cur_heat + map[next_pos]
        return next_heat if next_pos == target
        next_count = dir == last_dir ? last_count + 1 : 1
        next_item = [next_pos, dir]
        if best[next_item][next_count] > next_heat
          best[next_item][next_count] = next_heat
          i = 1
          while next_count + i <= 3
            best[next_item][next_count + i] = next_heat if best[next_item][next_count + i] > next_heat
            i += 1
          end

          queue.push([next_pos, dir, next_count], next_heat)
        end

      end

    end
    best.select{|k, v| k[0] == target}.values.map{|v| v.values.min}.min

  end

  def solve2(input)
    map = create_map(input)
    max = map.values.sum
    best = Hash.new {|h, k| h[k] = Hash.new(max)}
    best[[[0,0], [0,0]]][5] = 0

    target = [input[0].size - 2, input.size - 1]
    queue = PriorityQueue.new
    queue.push([[0,0], [0,0], 5], 0)
    while true
      pair = queue.min
      break if pair == nil
      p pair[0]
      pos, last_dir, last_count = pair[0]
      next if pos == target
      cur_heat = best[[pos, last_dir]][last_count]
      @@dir.each do |dir|
        next if last_dir == [dir[0] * -1, dir[1] * -1]
        next if dir != last_dir && last_count < 4
        next if dir == last_dir && last_count == 10
        next_pos = [pos[0] + dir[0], pos[1] + dir[1]]
        next_heat = cur_heat + map[next_pos]
        return next_heat if next_pos == target

        next_count = dir == last_dir ? last_count + 1 : 1
        next_item = [next_pos, dir]
        if best[next_item][next_count] > next_heat
          best[next_item][next_count] = next_heat
          queue.push([next_pos, dir, next_count], next_heat)
        end

      end

    end
    best.select{|k, v| k[0] == target}.values.map{|v| v.values.min}.min

  end



  private
  def create_map(input)
    worst = input.size * input[0].size * 9
    map = Hash.new(worst)
    input.each_with_index do |line, y|
      line.strip.split('').each_with_index do |c, x|
        map[[x,y]] = c.to_i
      end
    end
    map
  end
end

class PriorityQueue
  def initialize
    @arr = []
    @map = {}
    @changed = false
  end

  def push(item, priority)
    if @map.key? item
      @map[item][1] = priority
    else
      pair = [item, priority]
      @map[item] = pair
      @arr << pair
    end
    @changed = true
  end

  def min
    if @changed
      @arr.sort! { |x, y| x[1] <=> y[1] }
      @changed = false
    end
    pair = @arr.shift
    @map.delete(pair[0])
    pair
  end
end
