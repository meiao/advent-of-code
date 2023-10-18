#!/usr/local/bin/ruby

# This program answers Advent of Code 2015 day 16
#
# This version ran in
#
# Author::    Andre Onuki
# License::   GPL3
class Solver
  def initialize(input)
    @compounds = {
      'children' => 3,
      'cats' => 7,
      'samoyeds' => 2,
      'pomeranians' => 3,
      'akitas' => 0,
      'vizslas' => 0,
      'goldfish' => 5,
      'trees' => 3,
      'cars' => 2,
      'perfumes' => 1
    }

    @aunts = {}
    input.each do |line|
      data = line.split(' ')
      comps = {}
      comps[data[2][0..-2]] = data[3].to_i
      comps[data[4][0..-2]] = data[5].to_i
      comps[data[6][0..-2]] = data[7].to_i
      @aunts[data[1][0..-2].to_i] = comps
    end
  end

  def solve
    @aunts.each do |num, comps|
      is_aunt = true
      comps.each do |comp, count|
        if @compounds[comp] != count
          is_aunt = false
          break
        end
        break if !is_aunt
      end
      return num if is_aunt
    end
    nil
  end

  def solve2()
    @aunts.each do |num, comps|
      is_aunt = true
      comps.each do |comp, count|
        if ['cats', 'trees'].include?(comp)
          if @compounds[comp] >= count
            is_aunt = false
            break
          end
        elsif ['pomeranians', 'goldfish'].include?(comp)
          if @compounds[comp] <= count
            is_aunt = false
            break
          end
        else
          if @compounds[comp] != count
            is_aunt = false
            break
          end
        end
        break if !is_aunt
      end
      return num if is_aunt
    end
    nil
  end
end
