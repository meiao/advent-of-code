#!/usr/local/bin/ruby

# This program answers Advent of Code 2023 day 15
#
# Author::    Andre Onuki
# License::   GPL3
class Solver
  def solve(input)
    input[0].split(',').map{|instr| hash(instr.strip)}.sum
  end

  def hash(string)
    cur_val = 0
    string.each_char do |c|
      cur_val += c.ord
      cur_val *= 17
      cur_val %= 256
    end
    cur_val
  end

  def solve2(input)
    boxes = Hash.new {|hash, k| hash[k] = []}
    input[0].split(',').each do |instr|
      if instr.include? '-'
        remove(instr.strip, boxes)
      else
        set(instr.strip, boxes)
      end
    end
    calculate(boxes)
  end

  def remove(instr, boxes)
    label = instr[0..-2]
    box_no = hash(label)
    boxes[box_no].delete_if {|lens| lens[0] == label}
  end

  def set(instr, boxes)
    label, length = instr.split('=')
    box_no = hash(label)
    existing_lens = boxes[box_no].select {|lens| lens[0] == label}
    if existing_lens.size > 0
      existing_lens[0][1] = length.to_i
    else
      boxes[box_no] << [label, length.to_i]
    end
  end

  def calculate(boxes)
    boxes.map{|box_no, lenses| (box_no + 1) * calculate_lenses(lenses)}.sum
  end

  def calculate_lenses(lenses)
    lenses.each_with_index.map {|lens, i| (i+1) * lens[1]}.sum
  end
end
