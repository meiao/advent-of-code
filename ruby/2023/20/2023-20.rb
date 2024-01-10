#!/usr/local/bin/ruby

# This program answers Advent of Code 2023 day 20
#
# Author::    Andre Onuki
# License::   GPL3
class Solver

  def initialize(input)
    @bus = EventBus.new
    input.map(&:strip).each do |line|
      if line[0] == 'b'
        @broadcaster = Broadcaster.new(line, @bus)
      elsif line[0] == '%'
        FlipFlop.new(line, @bus)
      elsif line[0] == '&'
        Conjunction.new(line, @bus)
      end
    end
    @machine = Machine.new("?rx -> machine", @bus)
    @bus.calculate_inputs
  end


  def solve
    1000.times do |i|
      p i
      @bus.send(:low, 'button', ['roadcaster']) # broadcaster has its first char removed
      @bus.process_all
    end
    @bus.value
  end


  def solve2
    presses = 0
    until @machine.done?
      presses += 1
      StepCounter.i = presses
      @bus.send(:low, 'button', ['roadcaster']) # broadcaster has its first char removed
      @bus.process_all
    end
    presses
  end
end

class EventBus
  def initialize
    @queue = []
    @subscribers = {}
    @sent = {:high => 0, :low => 0}
  end

  def subscribe(name, mod)
    @subscribers[name] = mod
  end

  def calculate_inputs
    @subscribers.each do |name, mod|
      mod.dests.each do |dest|
        d = @subscribers[dest]
        if d != nil
          d.register_input(name)
        end
      end
    end
  end

  def send(level, src, dests)
    @sent[level] += dests.size
    dests.each do |dest|
      # next unless @subscribers.key? dest
      @queue << [level, src, dest]
    end
  end

  def process_all
    until @queue.empty?
      level, src, dest = @queue.shift
      next unless @subscribers.key? dest
      @subscribers[dest].on_signal(level, src)
    end
  end

  def value
    p @sent
    @sent[:low] * @sent[:high]
  end
end

class Mod
  attr_accessor :name, :dests
  def initialize(data, event_bus)
    name, dests = data.split(' -> ')
    @name = name[1..]
    @dests = dests.split(', ')
    @event_bus = event_bus
    event_bus.subscribe(@name, self)
  end

  def register_input(input)
    # only conjunctions implement this method
  end

  protected
  def send_pulse(level)
    @event_bus.send(level, @name, @dests)
  end
end

class Broadcaster < Mod
  def on_signal(level, src)
    send_pulse(level)
  end
end

class FlipFlop < Mod
  def on_signal(level, src)
    if level == :low
      @previous = @previous == :high ? :low : :high
      send_pulse(@previous)
    end
  end
end

class Conjunction < Mod
  def initialize(data, event_bus)
    super(data, event_bus)
    @inputs = {}
  end

  def register_input(input)
    @inputs[input] = :low
  end

  def on_signal(level, src)
    @inputs[src] = level
    all_high = @inputs.values.all? {|v| v == :high}
    p [self.name, StepCounter.i] if all_high && ['lg', 'st', 'bn', 'gr'].include?(self.name)
    send_pulse(all_high ? :low : :high)
  end
end

class Machine < Mod
  def on_signal(level, src)
    @done = true if level == :low
  end

  def done?
    @done != nil
  end
end

module StepCounter
  @@i = 0
  def self.i=(i)
    @@i = i
  end

  def self.i()
    @@i
  end
end
