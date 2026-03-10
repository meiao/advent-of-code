#!/usr/local/bin/ruby

# This program answers Advent of Code 2021 day 24
#
# Author::    Andre Onuki
# License::   GPL3
class Solver
  def solve1(input)
    acceptable_values(input, lambda { |st1, st2|
      if st1.input.to_i > st2.input.to_i
        st1
      else
        st2
      end
    }).max
  end

  def solve2(input)
    acceptable_values(input, lambda { |st1, st2|
      if st1.input.to_i < st2.input.to_i
        st1
      else
        st2
      end
    }).min
  end

  # 2 extra operations were implemented to speed up processing
  # neql a b, to avoid: eql a b; eql a 0;
  # set a b, to avoid: mul a 0; add a b;
  def acceptable_values(input, state_selector)
    states = [State.empty]
    i = 0
    input.each do |line|
      i += 1
      cmd, op1, op2 = line.split(' ')
      case cmd
      when 'inp'
        next_states = []
        states.each { |state| next_states.concat(state.inp(op1)) }
        states = consolidate(next_states, state_selector)
      when 'add'
        next if op2 == '0'

        states.each { |state| state.eval(->(a, b) { a + b }, op1, op2) }
      when 'mul'
        states.each { |state| state.eval(->(a, b) { a * b }, op1, op2) }
        states = consolidate(states, state_selector)
      when 'div'
        next if op2 == '1'

        states.each { |state| state.eval(->(a, b) { a / b }, op1, op2) }
        states = consolidate(states, state_selector)
      when 'mod'
        states.each { |state| state.eval(->(a, b) { a % b }, op1, op2) }
        states = consolidate(states, state_selector)
      when 'eql'
        states.each { |state| state.eval(->(a, b) { a == b ? 1 : 0; }, op1, op2) }
        states = consolidate(states, state_selector)
      when 'neql'
        states.each { |state| state.eval(->(a, b) { a == b ? 0 : 1; }, op1, op2) }
        states = consolidate(states, state_selector)
      when 'set'
        states.each { |state| state.eval(->(_, b) { b }, op1, op2) }
        states = consolidate(states, state_selector)
      end
    end
    states.filter { |state| state[:z] == 0 }.map(&:input).map(&:to_i)
  end

  def consolidate(states, state_selector)
    map = {}
    states.each do |state|
      vars = state.vars
      cur_state = map[vars]
      map[vars] = if cur_state.nil?
                    state
                  else
                    state_selector.call(state, cur_state)
                  end
    end
    map.values
  end

end

class State
  def initialize(vars, input)
    @vars = vars.clone
    @input = input
  end

  def inp(var)
    new_states = []
    sym = var.to_sym
    (1..9).each do |i|
      new_state = State.new(@vars, @input + i.to_s)
      new_state[sym] = i
      new_states << new_state
    end
    new_states
  end

  def eval(lambda, op1, op2)
    val1 = @vars[op1.to_sym]
    val2 = read(op2)
    @vars[op1.to_sym] = lambda.call(val1, val2)
  end

  def read(value)
    if %(w x y z).include?(value)
      @vars[value.to_sym]
    else
      value.to_i
    end
  end

  def []=(var, value)
    @vars[var] = value
  end

  def [](var)
    @vars[var]
  end

  attr_reader :vars, :input

  def self.empty
    State.new({ w: 0, x: 0, y: 0, z: 0 }, '')
  end

  def to_s
    'State (' + @input + ') ' + @vars.to_s
  end
end
