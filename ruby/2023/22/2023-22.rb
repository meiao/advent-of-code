#!/usr/local/bin/ruby

# This program answers Advent of Code 2023 day 22
#
# Author::    Andre Onuki
# License::   GPL3
class Solver
  def solve(input)
    blocks = input.map { |line| Block.create(line) }.sort
    settle(blocks)
    supporters = supporters(blocks)
    must_keep = supporters.select { |list| list.size == 1 }.flatten.uniq.count
    blocks.size - must_keep
  end

  def settle(blocks)
    settled_blocks = []
    blocks.each_with_index do |block, _i|
      loop do
        break if block.at_ground?

        below = block.bottom
        below.fall
        break if settled_blocks.any? { |b| b.intersect(below) }

        block.fall
      end
      settled_blocks.unshift(block)
    end
  end

  def supporters(blocks)
    supporters = []
    blocks.size.times { supporters << [] }
    blocks.each_with_index do |block, i|
      next if block.at_ground?

      below = block.bottom
      below.fall
      blocks.each_with_index do |b, j|
        next if i == j

        supporters[i] << j if b.intersect(below)
      end
    end
    supporters
  end

  def supported(blocks)
    supported = []
    blocks.size.times { supported << [] }
    blocks.each_with_index do |block, i|
      next if block.at_ground?

      below = block.bottom
      below.fall
      blocks.each_with_index do |b, j|
        next if i == j

        supported[j] << i if b.intersect(below)
      end
    end
    supported
  end

  def solve2(input)
    blocks = input.map { |line| Block.create(line) }.sort
    settle(blocks)
    supporters = supporters(blocks)
    supported = supported(blocks)
    blocks.size.times.map { |i| falling_blocks(i, supported, supporters) }.sum
  end

  def falling_blocks(initial, supported, supporters)
    queue = [initial]
    will_fall = Hash.new(false)
    will_fall[initial] = true
    until queue.empty?
      i = queue.pop
      supported[i].each do |j|
        next if will_fall[j]
        next unless supporters[j].all? { |x| will_fall[x] }

        will_fall[j] = true
        queue << j
      end
    end
    will_fall.size - 1
  end
end

class Block
  attr_accessor :x, :y, :z

  def self.create(line)
    p1, p2 = line.strip.split('~').map { |c| c.split(',') }
    x = [p1[0].to_i, p2[0].to_i].sort
    y = [p1[1].to_i, p2[1].to_i].sort
    z = [p1[2].to_i, p2[2].to_i].sort
    Block.new(x, y, z)
  end

  def fall
    @z.map! { |v| v - 1 }
  end

  def bottom
    Block.new(
      [@x[0], @x[1]],
      [@y[0], @y[1]],
      [@z[0], @z[0]]
    )
  end

  def intersect(block)
    pair_intersect(@x, block.x) && pair_intersect(@y, block.y) && pair_intersect(@z, block.z)
  end

  def min_height
    @z[0]
  end

  def at_ground?
    @z[0] == 1
  end

  def <=>(other)
    @z[0] <=> other.z[0]
  end

  private

  def initialize(x, y, z)
    @x = x
    @y = y
    @z = z
  end

  def pair_intersect(p1, p2)
    p1[0] <= p2[1] && p2[0] <= p1[1]
  end
end
