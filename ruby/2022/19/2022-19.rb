#!/usr/local/bin/ruby

# This program answers Advent of Code 2022 day 19
# I cheated and looked for some ideas in reddit. The ideas that helped me were:
# 1. whenever you wait and you could have built a type of robot, do not create that type of robot in the next minute
# 2. do not create more of one type of robot than the max cost of that resource. ie, if the recipe that uses the max ore uses 5 ores, do not have more than 5 ore robots.
# This version ran in
#
# Author::    Andre Onuki
# License::   GPL3

module Resources
  LIST = [:geode, :obsidian, :clay, :ore]
end

class Solver
  def solve(input, time)
    status = Status.initial(time)
    input.map{|line| Blueprint.new(line)}.map{|blueprint| blueprint.id * blueprint.calculate([status], time)}.sum
  end

  def solve2(input, time, lines)
    status = Status.initial(time)
    input[0..(lines - 1)].map{|line| Blueprint.new(line).calculate([status], time)}.reduce(1){|x,y| x*y}
  end
end

class Blueprint
  attr_reader :id
  def initialize(line)
    tokens = line.split(' ')
    @id = tokens[1].to_i
    @costs = {
      :ore => {:ore => tokens[6].to_i, :clay => 0, :obsidian => 0},
      :clay => {:ore => tokens[12].to_i, :clay => 0, :obsidian => 0},
      :obsidian => {:ore => tokens[18].to_i, :clay => tokens[21].to_i, :obsidian => 0},
      :geode => {:ore => tokens[27].to_i, :clay => 0, :obsidian => tokens[30].to_i}
    }.freeze
    @max_costs = {}
    Resources::LIST.each do |r|
      @max_costs[r] = @costs.values.map{|costs| costs[r]}.max
    end
  end

  def calculate(statuses, time)
    cur_statuses = statuses
    time.times do |i|
      p i
      cur_statuses = cur_statuses.map{|status| status.next_statuses(@costs, @max_costs)}.flatten
      cur_statuses = clean_statuses(cur_statuses)
    end
    max = cur_statuses.map{|status| status.resources[:geode]}.max
    max
  end

  def clean_statuses(statuses)
    if statuses.size > 10000
      p statuses.size
      return statuses
    end
    cur_statuses = statuses.sort{|x, y| y.value <=> x.value}
    next_statuses = []
    until cur_statuses.empty?
      status = cur_statuses.pop
      if cur_statuses.none?{|s| status.is_worse_than?(s)}
        next_statuses << status
      end
    end
    p "#{statuses.size} -> #{next_statuses.size}"
    next_statuses
  end

end

class Status
  attr_reader :time, :resources, :bots, :could_have_built
  def initialize(resources, bots, could_have_built, time)
    @resources = resources
    @bots = bots
    @time = time
    @could_have_built = could_have_built
  end

  def next_statuses(costs, max_costs)
    next_resources = {}
    Resources::LIST.each do |resource|
      next_resources[resource] = @resources[resource] + @bots[resource]
    end
    statuses = []
    could_have_built = Resources::LIST.filter { |resource| costs[resource].all?{|k, v| @resources[k] >= v} }
    base_status = Status.new(next_resources, @bots, could_have_built, time - 1)
    statuses.concat(buy_statuses(base_status, costs, max_costs))
    statuses << base_status
  end

  def buy_statuses(status, costs, max_costs)
    next_statuses = []
    resources = Resources::LIST
    resources -= @could_have_built
    resources.each do |resource|
      next if @bots[resource] == max_costs[resource]
      if costs[resource].all?{|k, v| @resources[k] >= v}
        next_resources = Hash[status.resources]
        costs[resource].each {|k, v| next_resources[k] -= v}
        next_bots = Hash[status.bots]
        next_bots[resource] += 1
        next_statuses << Status.new(next_resources, next_bots, [], status.time)
      end
    end
    next_statuses
  end

  def score
    @resources[:geode]
  end

  def value
    [@bots.values.sum, @resources.values.sum]
  end

  def is_worse_than?(status)
    Resources::LIST.all?{|r| @bots[r] <= status.bots[r] && @resources[r] <= status.resources[r]}
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
    Status.new(initial_resources, initial_bots, [], time)
  end
end

class Solver2
  def solve
  end
end
