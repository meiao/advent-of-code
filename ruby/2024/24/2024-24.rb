#!/usr/local/bin/ruby

# This program answers Advent of Code 2024 day 24
#
# Author::    Andre Onuki
# License::   GPL3
class Solver
  def solve(wires, raw_gates)
    wire_map = init_wire_map(wires)
    gates = init_gates(raw_gates)
    execute(wire_map, gates)
  end

  def init_wire_map(wires)
    wire_map = {}
    wires.each do |wire|
      code, value = wire.split(': ')
      wire_map[code] = value == '1'
    end
    wire_map
  end

  def init_gates(raw_gates)
    raw_gates.map { |gate| Gate.new(gate) }
  end

  def execute(wire_map, gates)
    counter = 0
    until gates.empty?
      gate = gates.shift
      if gate.apply(wire_map)
        counter = 0
      else
        gates << gate
        counter += 1
        return -1 if counter > gates.size
      end
    end
    wire_map.keys
            .filter { |key| key[0] == 'z' }
            .sort
            .reverse
            .map { |key| wire_map[key] ? '1' : '0' }
            .join
            .to_i(2)
  end

  def solve2(raw_gates)
    gates = init_gates(raw_gates)
    gate_by_output = map_gate_by_output(gates)
    outputs = raw_gates.map { |gate| gate.split(' -> ')[1] }
    find_permutation(gate_by_output, outputs)
  end

  def map_gate_by_output(gates)
    gates.to_h { |gate| [gate.output, gate] }
  end

  def set_wire(prefix, number, wire_map)
    45.times do |i|
      wire_map[wire_name(prefix, i)] = number.odd?
      number >>= 1
    end
  end

  def wire_name(prefix, i)
    prefix + i.to_s.rjust(2, '0')
  end

  def test(x, y, gates)
    wire_map = {}
    set_wire('x', x, wire_map)
    set_wire('y', y, wire_map)
    execute(wire_map, gates)
  end

  def find_permutation(gates_by_output, bad_outputs)
    bad_outputs.reject! { |output| %w[sps tst frt].include?(output) }
    bad_outputs.reject! { |output| output[0] == 'z' }

    bad_outputs.to_a.combination(2).each do |combo|
      # looking at the input, there are some rules that are broken:
      # 1. if an output is z, then the operation must be XOR
      # 2. if output is not z and inputs are not x and y, the operation must not be XOR
      # The following break these rules, so (because the input are doctored) they must
      # be swapped by themselves. Then just need to find the 2 remaining bad outputs
      fixed_swaps = %w[sps tst frt].permutation.map { |p| p.zip(%w[z05 z11 z23]) }
      fixed_swaps.each do |swaps|
        swaps << combo
        p swaps
        swaps.each do |outputs|
          gates_by_output[outputs[0]].override = outputs[1]
          gates_by_output[outputs[1]].override = outputs[0]
        end
        errors = false
        45.times do |i|
          two_to_i = 2**i
          unless test(two_to_i, 0, gates_by_output.values) == two_to_i
            errors = true
            break
          end
          unless test(0, two_to_i, gates_by_output.values) == two_to_i
            errors = true
            break
          end
          unless test(two_to_i, two_to_i, gates_by_output.values) == two_to_i * 2
            errors = true
            break
          end
        end
        wires = swaps.flatten
        return wires.sort unless errors

        wires.each { |output| gates_by_output[output].reset }
      end
    end
    false
  end

  def valid?(swaps)
    used = Hash.new(false)
    swaps.flatten(1).each do |wire|
      return false if used[wire]

      used[wire] = true
    end
    true
  end
end

class Gate
  def initialize(gate)
    @wire1, op, @wire2, _, @output = gate.split(' ')
    case op
    when 'AND'
      @op = ->(wire1, wire2) { wire1 && wire2 }
    when 'OR'
      @op = ->(wire1, wire2) { wire1 || wire2 }
    when 'XOR'
      @op = ->(wire1, wire2) { wire1 ^ wire2 }
    end
  end

  attr_reader :output
  attr_writer :override

  def apply(wire_map)
    return false if wire_map[@wire1].nil? || wire_map[@wire2].nil?

    output = @override.nil? ? @output : @override
    wire_map[output] = @op.call(wire_map[@wire1], wire_map[@wire2])
    true
  end

  def read_from?(wire)
    [@wire1, @wire2].include?(wire)
  end

  def reset
    @override = nil
  end
end
