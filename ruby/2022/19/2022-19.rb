#!/usr/local/bin/ruby

# This program answers Advent of Code 2022 day 19
#
# This version ran in
#
# Author::    Andre Onuki
# License::   GPL3

module Resources
  LIST = [:geode, :obsidian, :clay, :ore]
end

class Solver
  def solve(input, time)
    input.map{|line| Blueprint.new(line).calculate(Status.initial(time))}.sum
  end
end

class Blueprint
  def initialize(line)
    tokens = line.split(' ')
    @id = tokens[1].to_i
    @costs = {
      :ore => {:ore => tokens[6].to_i, :clay => 0, :obsidian => 0},
      :clay => {:ore => tokens[12].to_i, :clay => 0, :obsidian => 0},
      :obsidian => {:ore => tokens[18].to_i, :clay => tokens[21].to_i, :obsidian => 0},
      :geode => {:ore => tokens[27].to_i, :clay => 0, :obsidian => tokens[30].to_i}
    }.freeze
    @max = 0
  end

  def calculate(status)
    recurse(status)
    @max * @id
  end

  def recurse(status)
    if status.time == 0
      if status.score > @max
        @max = status.score
        p @max
      end
      return
    end
    if status.score + (status.time*(status.time - 1)/2) < @max
      p "discarded with time #{status.time}"
      return
    end
    status.next_statuses(@costs).each{|st| recurse(st)}
  end
end

class Status
  attr_reader :time, :resources, :bots
  def initialize(resources, bots, time)
    @resources = resources
    @bots = bots
    @time = time
  end

  def next_statuses(costs)
    next_resources = {}
    Resources::LIST.each do |resource|
      next_resources[resource] = @resources[resource] + @bots[resource]
    end
    statuses = []
    base_status = Status.new(next_resources, @bots, time - 1)
    statuses.concat(buy_statuses(base_status, costs))
    statuses << base_status
  end

  def buy_statuses(status, costs)
    next_statuses = []
    Resources::LIST.each do |resource|
      if costs[resource].all?{|k, v| @resources[k] >= v}
        next_resources = Hash[status.resources]
        costs[resource].each {|k, v| next_resources[k] -= v}
        next_bots = Hash[status.bots]
        next_bots[resource] += 1
        next_statuses << Status.new(next_resources, next_bots, status.time)
      end
    end
    next_statuses
  end

  def score
    @resources[:geode]
  end

  def self.initial(time)
    initial_resources = {
      :geode => 0,
      :obsidian => 0,
      :clay => 0,
      :ore => 0
    }
    initial_bots = {
      :ore => 1,
      :clay => 0,
      :obsidian => 0,
      :geode => 0
    }
    Status.new(initial_resources, initial_bots, time)
  end
end

class Solver2
  def solve
  end
end
