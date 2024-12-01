#!/usr/local/bin/ruby

# This program answers Advent of Code 2023 day 24
#
# Author::    Andre Onuki
# License::   GPL3
class Solver
  def initialize(input)
    @hails = input.map { |line| line.strip.split(' @ ').map { |arr| arr.split(', ').map(&:to_f) } }
  end

  def solve(min, max)
    sum = 0
    delta = [0, 0]
    @hails.size.times do |i|
      ((i + 1)..(@hails.size - 1)).each do |j|
        coord, times = meet(@hails[i], @hails[j], delta)
        x, y = coord
        a, b = times
        next if a < 0 || b < 0
        next if x < min || x > max
        next if y < min || y > max

        sum += 1
      end
    end
    sum
  end

  # there is something wonky with this method
  # large input did not work at first
  # moved the first 2 hails to the bottom of the list and it worked
  def meet(h1, h2, delta)
    # a is the time when h1 hits the point
    a = (h2[0][0] - h1[0][0]) * (h2[1][1] + delta[1]) - (h2[0][1] - h1[0][1]) * (h2[1][0] + delta[0])
    a /= (h1[1][0] + delta[0]) * (h2[1][1] + delta[1]) - (h1[1][1] + delta[1]) * (h2[1][0] + delta[0])
    x = a * (h1[1][0] + delta[0]) + h1[0][0]
    y = a * (h1[1][1] + delta[1]) + h1[0][1]
    # b is the time when h2 hits the point
    b = a * (h1[1][0] + delta[0]) + h1[0][0] - h2[0][0]
    b /= (h2[1][0] + delta[0])
    [[x, y], [a, b]]
  end

  def solve2
    # assume the stone is stopped, and instead, brute force
    # the change in speed needed so all the flakes hit a specific point
    encounter = nil
    (-1000..1000).each do |dx|
      (-1000..1000).each do |dy|
        encounter = find_encounter([dx, dy])
        break unless encounter.nil?
      end
      break unless encounter.nil?
    end
    coords, times = encounter
    h0, h1 = @hails[0..1]
    z0 = h0[0][2] + (times[0] * h0[1][2])
    z1 = h1[0][2] + (times[1] * h1[1][2])
    coords << (((times[1] * z0) - (times[0] * z1)) / (times[1] - times[0])).floor
    coords.sum
  end

  def find_encounter(delta)
    encounter = meet(@hails[0], @hails[1], delta)
    # ignoring non integer numbers
    return nil unless encounter.flatten.filter { |n| n.nan? }.empty?
    return nil unless encounter.flatten.filter { |n| n.infinite? }.empty?
    return nil unless encounter.flatten.filter { |n| n != n.floor }.empty?

    coord, time = encounter
    # ignoring negative times
    return nil unless time.filter { |t| t < 0 }.empty?

    time.map! { |t| t.floor }
    coord.map! { |c| c.floor }
    @hails[2..].each do |hail|
      # if any hail cannot hit the encounter spot, must find another
      return nil unless hits(hail, coord, delta)
    end
    [coord, time]
  end

  def hits(hail, coord, delta)
    vx = hail[1][0] + delta[0]
    x = coord[0] - hail[0][0]
    tx = nil
    if vx == 0
      return false if x != 0
    else
      return false if x % vx != 0

      tx = x / vx
      return false if tx < 0
    end
    vy = hail[1][1] + delta[1]
    y = coord[1] - hail[0][1]
    ty = nil
    if vy == 0
      return false if y != 0
    else
      return false if y % vy != 0

      ty = y / vy
      return false if ty < 0
    end
    tx.nil? || ty.nil? || tx == ty
  end
end
