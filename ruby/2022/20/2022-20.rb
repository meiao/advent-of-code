#!/usr/local/bin/ruby

# This program answers Advent of Code 2022 day 20
#
# This version ran in
#
# Author::    Andre Onuki
# License::   GPL3
class Solver
  def solve(input, multiplier, mixes)
    head = Node.new(nil)
    prev_node = head
    size = 0
    zero = nil
    input.each do |line|
      value = line.to_i
      next_node = Node.new(value * multiplier)
      prev_node.nexts = next_node
      next_node.prev_order = prev_node
      prev_node = next_node
      zero = next_node if value == 0
      size += 1
    end
    head = head.next_order
    head.prev_order = prev_node
    prev_node.next_order = head

    modulo = size - 1
    mixes.times do
      cur = head
      until cur.nil?
        cur.move(modulo)
        cur = cur.next_orig
        # print(head, size)
      end
    end

    sum = 0
    cur = zero
    3.times do
      1000.times do
        cur = cur.next_order
      end
      sum += cur.value
    end
    sum
  end

  def print(head, size)
    cur = head
    size.times do
      p cur.value
      cur = cur.next_order
    end
    puts
  end
end

class Node
  attr_accessor :value, :next_orig, :prev_order, :next_order

  def initialize(value)
    @value = value
  end

  def nexts=(node)
    @next_orig = node
    @next_order = node
  end

  def move(modulo)
    if value > 0
      move_forward(modulo)
    else
      move_backward(modulo)
    end
  end

  def move_forward(modulo)
    cur = self
    (@value % modulo).times do
      cur = cur.next_order
    end
    remove
    insert_after(cur)
  end

  def move_backward(modulo)
    cur = self
    (@value.abs % modulo).times do
      cur = cur.prev_order
    end
    remove
    insert_after(cur.prev_order)
  end

  def remove
    @prev_order.next_order = @next_order
    @next_order.prev_order = @prev_order
  end

  def insert_after(node)
    @next_order = node.next_order
    node.next_order = self
    @prev_order = node
    @next_order.prev_order = self
  end
end
