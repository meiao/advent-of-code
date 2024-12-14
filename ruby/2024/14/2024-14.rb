#!/usr/local/bin/ruby

# This program answers Advent of Code 2024 day 14
#
# Author::    Andre Onuki
# License::   GPL3
class Solver
  def solve(input, limits)
    middle = limits.map { |c| c / 2 }
    input.map { |line| Robot.new(line) }
         .map { |r| r.move(100, limits) }
         .map { |pos| quadrant(pos, middle) }
         .compact
         .each_with_object(Hash.new(0)) do |quad, hash|
      hash[quad] += 1
    end
         .values
         .inject(:*)
  end

  def quadrant(pos, middle)
    return nil if pos[0] == middle[0] || pos[1] == middle[1]

    sum = 0
    sum += 1 if pos[0] > middle[0]
    sum += 2 if pos[1] > middle[1]
    sum
  end

  def solve2(input, limits)
    robots = input.map { |line| Robot.new(line) }
    count = 0
    while true
      p count
      print_robots(robots, limits)
      steps = gets.chomp.to_i
      p steps
      steps = 1 if steps == 0
      count += steps
      robots.each { |r| r.move(steps, limits) }
    end
  end

  def print_robots(robots, limits)
    hash = Hash.new(' ')
    robots.map(&:pos).each { |pos| hash[pos] = '#' }
    (0..limits[1]).each do |y|
      (0..limits[0]).each do |x|
        print(hash[[x, y]])
      end
      puts
    end
  end
end

class Robot
  @@regex = /p=(\d+),(\d+) v=(-?[0-9]+),(-?[0-9]+)/
  def initialize(line)
    matches = @@regex.match(line)
    @x, @y, @vx, @vy = matches.captures.map(&:to_i)
  end

  def move(times, limits)
    times.times do
      @x += @vx
      @y += @vy
      @x %= limits[0]
      @y %= limits[1]
      @x += limits[0] if @x < 0
      @y += limits[1] if @y < 0
    end
    [@x, @y]
  end

  def pos
    [@x, @y]
  end
end
