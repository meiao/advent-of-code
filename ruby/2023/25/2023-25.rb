#!/usr/local/bin/ruby

# This program answers Advent of Code 2023 day 25
# It uses ideas from Karger's algorithm, but instead of always
# joining randomly, it will join:
# - the pair with the most connections, if it has more than 3 connections
# - a random pair.
# The random pair will ignore one pair that has 3 connections, so that can be
# left for last to find the answer.
# Author::    Andre Onuki
# License::   GPL3
class Solver
  def solve(input)
    map = create_map(input)
    join_singles!(map)
    loop do
      new_map = map.clone
      new_map.default = 0
      cut = find_cut!(new_map)
      components, cut_size = cut.each.next
      return components[0].size * components[1].size if cut_size == 3
    end
  end

  def create_map(input)
    map = Hash.new(0)
    input.each do |line|
      first, others = line.split(': ')
      others.split(' ').each do |second|
        key = [[first], [second]].sort
        map[key] = 1
      end
    end
    map
  end

  def join_singles!(map)
    count = Hash.new(0)
    map.keys.each do |arr|
      arr.each do |comps|
        count[comps[0]] += 1
      end
    end
    singles = count.select {|k, v| v == 1}.keys

    pairs_to_join = map.keys.select{|k| k.any? {|comps| comps.intersect? singles}}
    pairs_to_join.each do |comps|
      join!(map, comps)
    end
  end

  def find_cut!(map)
    while map.size > 1
      arr = map.to_a.sort{|a,b| a[1] <=> b[1]}
      k, v = arr[-1]
      if v == 3
        k, v = arr[rand(map.size - 1)]
      elsif v < 3
        k, v = arr[rand(map.size)]
      end
      join!(map, k)
    end
    map
  end

  def join!(map, comps)
    new_comp = comps.flatten.sort
    map.delete(comps)
    map.keys.each do |key|
      if key.intersect? comps
        count = map.delete(key)
        new_key = key.select {|comp| !comps.include? comp}
        new_key << new_comp
        new_key.sort!
        map[new_key] += count
      end
    end
  end


  def solve2(input)
  end
end
