#!/usr/local/bin/ruby

# This program answers Advent of Code 2024 day 23
#
# Author::    Andre Onuki
# License::   GPL3
class Solver
  def solve(input)
    map = create_map(input)
    groups = find_groups(map)
    groups.filter { |group| group.any? { |comp| comp.start_with?('t') } }.size
  end

  def create_map(input)
    map = Hash.new { |h, k| h[k] = Hash.new(false) }
    input.each do |line|
      c1, c2 = line.split('-')
      map[c1][c2] = true
      map[c2][c1] = true
    end
    map
  end

  def find_groups(map)
    trios = []
    map.keys.each do |c1|
      connections = map[c1].keys
      connections.each do |c2|
        trios.concat(find_trio([c1, c2], map))
      end
    end
    trios.uniq
  end

  def find_trio(pair, map)
    c1 = pair[0]
    c2 = pair[1]
    trios = []
    connections = map[c2].keys
    connections.each do |c3|
      trios << c3 if map[c3].include?(c1)
    end
    trios.map { |c3| pair.clone << c3 }.map(&:sort)
  end

  def solve2(input)
    map = create_map(input)
    @largest_group = []
    find_largest_group(map)
    @largest_group.sort.join(',')
  end

  def find_largest_group(map)
    checked = Hash.new(false)
    largest_group = []
    map.keys.each do |comp|
      group = grow_group([comp], map, checked)
      largest_group = group if group.size > largest_group.size
      checked[comp] = true
    end
    largest_group
  end

  def grow_group(group, map, checked)
    @largest_group = group.clone if group.size > @largest_group.size
    already_checked = checked.clone
    cur_comp = group[-1]
    connections = map[cur_comp].keys
    connections.filter { |next_comp| !checked[next_comp] }
               .filter { |next_comp| !group.include?(next_comp) }
               .filter { |next_comp| map[next_comp].size > @largest_group.size }
               .filter { |next_comp| linked_to_all(group, next_comp, map) }
               .each do |next_comp|
                 group << next_comp
                 grow_group(group, map, already_checked)
                 group.pop
                 already_checked[next_comp] = true
               end
  end

  def linked_to_all(group, comp, map)
    comp_connections = map[comp]
    group.all? { |c| comp_connections[c] }
  end
end
