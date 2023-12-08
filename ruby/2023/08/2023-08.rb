#!/usr/local/bin/ruby

# This program answers Advent of Code 2023 day 08
#
# Author::    Andre Onuki
# License::   GPL3
class Solver
  def solve(input)
    instructions = input[0].strip.tr('LR', '01').split('').map{|c| c.to_i}

    map = create_map(input[2..])
    location = 'AAA'
    steps = 0
    while location != 'ZZZ'
      location = map[location][instructions[steps%instructions.size]]
      steps += 1
    end

    steps
  end

  def create_map(data)
    map = {}
    regex = /(?<origin>\w{3}) = \((?<left>\w{3}), (?<right>\w{3})\)/
    data.each do |line|
      match = line.match(regex)
      map[match[:origin]] = [match[:left], match[:right]]
    end
    map
  end

  def solve2(input)
    instructions = input[0].strip.tr('LR', '01').split('').map{|c| c.to_i}

    map = create_map(input[2..])

    locations = map.keys.filter {|key| key[-1] == 'A'}
    steps = 0
    while should_continue?(locations)
      locations.size.times do |i|
        locations[i] = map[locations[i]][instructions[steps%instructions.size]]
      end
      steps += 1
    end

    steps
  end

  def should_continue?(locations)
    locations.any?{|location| location[-1] != 'Z'}
  end
end
