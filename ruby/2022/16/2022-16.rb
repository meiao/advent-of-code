#!/usr/local/bin/ruby

# This program answers Advent of Code 2022 day 16
#
# This version ran in
#
# Author::    Andre Onuki
# License::   GPL3
class Solver
  def initialize(input)
    @valves = {}
    input.map { |line| Valve.new(line) }
         .each { |valve| @valves[valve.name] = valve }
    @valves.values.each { |valve| valve.valves = @valves }
    @max_flow = @valves.values.map { |v| v.flow }.max
  end

  def solve
    @best_status = Status.new(@valves['AA'], nil, [], 0, 0)
    recurse(Status.new(@valves['AA'], nil, [], 0, 30))
    @best_status.score
  end

  def recurse(status)
    if status.time_left == 0
      @best_status = status if status.score > @best_status.score
      return
    end
    return if status.time_left**2 * @max_flow / 2 + status.score < @best_status.score

    recurse(status.open) if !status.open_valves.include?(status.valve) && status.valve.flow > 0
    status.valve.valves.each do |next_valve|
      recurse(status.move(next_valve)) unless next_valve == status.prev_valve
    end
  end
end

class Valve
  attr_reader :name, :flow, :valves

  def initialize(line)
    data = line.match(/Valve (.*) has flow rate=(\d+); tunnels? leads? to valves? (.*)/)
    @name = data[1]
    @flow = data[2].to_i
    @tunnels = data[3].strip.split(', ')
  end

  def valves=(valves)
    @valves = @tunnels.map { |t| valves[t] }
  end
end

class Status
  attr_reader :valve, :prev_valve, :open_valves, :score, :time_left

  def initialize(valve, prev_valve, open_valves, score, time_left)
    @valve = valve
    @prev_valve = prev_valve
    @open_valves = open_valves
    @score = score
    @time_left = time_left
  end

  def open
    next_time_left = @time_left - 1
    next_score = @valve.flow * next_time_left + @score
    next_open_valves = Array.new(open_valves) << @valve
    Status.new(@valve, nil, next_open_valves, next_score, next_time_left)
  end

  def move(valve)
    Status.new(valve, @valve, @open_valves, @score, @time_left - 1)
  end
end

class Solver2
  def initialize(input)
    @valves = {}
    input.map { |line| Valve.new(line) }
         .each { |valve| @valves[valve.name] = valve }
    @valves.values.each { |valve| valve.valves = @valves }
    @valves.values.map { |v| v.flow }
  end

  def solve
    @best_score = 0
    aa_valve = @valves['AA']
    initial_status = Array.new(2, SingleStatus.new(aa_valve, aa_valve))
    recurse(GroupStatus.new(initial_status, @valves.values, [], 0, 26))
    @best_score
  end

  def recurse(group_status)
    if group_status.time_left == 0 || group_status.closed_valves.empty?
      @best_score = group_status.score if group_status.score > @best_score
      return
    end
    return if group_status.cant_match(@best_score)

    next_statuses = group_status.next_statuses
    time_left = group_status.time_left - 1
    next_statuses[0].each do |next_status0|
      next_statuses[1].each do |next_status1|
        next if next_status0.prev_valve.nil? && next_status0 == next_status1

        closed_valves = group_status.closed_valves
        open_valves = group_status.open_valves
        score = group_status.score
        recurse(GroupStatus.new([next_status0, next_status1],
                                closed_valves, open_valves, score, time_left))
      end
    end
  end
end

class SingleStatus
  attr_reader :valve, :prev_valve

  def initialize(valve, prev_valve)
    @valve = valve
    @prev_valve = prev_valve
  end

  def open
    SingleStatus.new(@valve, nil)
  end

  def move(valve)
    SingleStatus.new(valve, @valve)
  end

  def ==(other)
    @valve == other.valve && @prev_valve == other.prev_valve
  end
end

class GroupStatus
  attr_reader :statuses, :closed_valves, :open_valves, :score, :time_left

  def initialize(statuses, closed_valves, open_valves, score, time_left)
    if statuses.any? { |st| st.prev_valve.nil? }
      @open_valves = Array.new(open_valves)
      @closed_valves = Array.new(closed_valves)
    else
      @open_valves = open_valves
      @closed_valves = closed_valves
    end
    @statuses = statuses
    @score = score
    @time_left = time_left
    statuses.each do |status|
      next unless status.prev_valve.nil?

      @open_valves << status.valve
      @closed_valves.delete(status.valve)
      @score += time_left * status.valve.flow
    end
  end

  def next_statuses
    @statuses.map do |st|
      next_status = []
      next_status << st.open if !@open_valves.include?(st.valve) && st.valve.flow > 0
      st.valve.valves.each do |next_valve|
        next_status << st.move(next_valve) unless st.prev_valve == next_valve
      end
      next_status
    end
  end

  def cant_match(best_score)
    @time_left * @closed_valves.map { |v| v.flow }.sum + @score < best_score
  end
end
