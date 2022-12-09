#!/usr/local/bin/ruby

# This program answers Advent of Code 2022 day 08
#
# This version ran in
#
# Author::    Andre Onuki
# License::   GPL3
class Solver
  def initialize(input)
    @board = input.map {|line| line.strip.chars.map{|c| c.to_i}}
    @width = @board[0].size
    @height = @board.size
    @start_point_direction = [
      [0, 0, :down, :right],
      [0, 0, :right, :down],
      [@height - 1, @width - 1,:left, :up],
      [@height - 1, @width - 1, :up, :left]
    ]
    @visible = {}

  end

  def solve
    @start_point_direction.each do |point_dir|
      traverse_side(point_dir[0..1], point_dir[2..3])
    end
    @visible.size
  end

  def traverse_side(start, directions)
    loop do
      cur = Array.new(start)
      traverse_single(cur, directions[1])
      move(start, directions[0])
      break if height(start) == nil
    end
  end

  def traverse_single(cur, direction)
    tallest = -1
    loop do
      cur_height = height(cur)
      break if cur_height == nil
      if cur_height > tallest
        mark_visible(cur)
        tallest = cur_height
        break if tallest == 9
      end
      move(cur, direction)
    end
  end


  def height(point)
    return nil if point[0] < 0 || point[1] < 0 || @board[point[0]] == nil
    @board[point[0]][point[1]]
  end

  def move(point, direction)
    if direction == :up
      point[0] -= 1
    elsif direction == :down
      point[0] += 1
    elsif direction == :right
      point[1] += 1
    elsif direction == :left
      point[1] -= 1
    else
      raise 'invalid direction'
    end
  end

  def mark_visible(point)
    @visible[Array.new(point)] = true
  end


  def solve2
    max = 0
    (1..(@board.size() -2)).each do |i|
      (1..(@board[0].size() -2)).each do |j|
        score = scenic_score([i, j])
        max = score if score > max
      end
    end
    max
  end

  def scenic_score(point)
    score = 1
    [:up, :down, :left, :right].each do |direction|
      score *= direction_score(Array.new(point), direction)
    end
    score
  end

  def direction_score(point, direction)
    visible = 0
    max_height = height(point)
    tallest = -1
    loop do
      move(point, direction)
      cur_height = height(point)
      break if cur_height == nil
      visible += 1
      if cur_height >= tallest
        tallest = cur_height
        break if tallest >= max_height
      end
    end
    visible
  end

end
