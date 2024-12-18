#!/usr/local/bin/ruby

# This program answers Advent of Code 2024 day 17
#
# Author::    Andre Onuki
# License::   GPL3
class Solver
  def solve(input, registers)
    program = input.split(',')
    output = ConsoleOutput.new
    Computer.new(registers).execute(program, output)
    output.get
  end

  def solve2(input)
    program = input.split(',')
    program.freeze
    a = '4632'.to_i(8)
    inc = '10000000'.to_i(8)
    bs = %w[260000 3260000 4220000 4260000 4420000 4720000].map { |b| b.to_i(8) }
    loop do
      bs.each do |b|
        ab = a + b
        output = OutputVerifier.new(program)
        registers = { a: ab, b: 0, c: 0 }
        return ab if Computer.new(registers).execute(program, output) && output.valid?
      end
      a += inc
    end
  end
end

class Computer
  def initialize(registers)
    @registers = registers
    @instr_ptr = 0
  end

  def execute(program, output)
    until @instr_ptr >= program.length
      opcode = program[@instr_ptr]
      value = program[@instr_ptr + 1]
      case opcode
      when '0'
        @registers[:a] = @registers[:a] / (2**combo(value))
      when '1'
        @registers[:b] = @registers[:b] ^ value.to_i
      when '2'
        @registers[:b] = combo(value) % 8
      when '3'
        @instr_ptr = (value.to_i - 2) unless @registers[:a] == 0
      when '4'
        @registers[:b] = @registers[:b] ^ @registers[:c]
      when '5'
        return false unless output.print(combo(value) % 8)
      when '6'
        @registers[:b] = @registers[:a] / (2**combo(value))
      when '7'
        @registers[:c] = @registers[:a] / (2**combo(value))
      end
      @instr_ptr += 2
    end
    true
  end

  def combo(value)
    case value
    when '0', '1', '2', '3'
      value.to_i
    when '4'
      @registers[:a]
    when '5'
      @registers[:b]
    when '6'
      @registers[:c]
    end
  end
end

class ConsoleOutput
  def initialize
    @output = []
  end

  def print(value)
    @output << value
    true
  end

  def get
    @output.map(&:to_s).join(',')
  end
end

class OutputVerifier
  def initialize(program)
    @i = 0
    @program = program
  end

  def print(value)
    return false unless value.to_s == @program[@i]

    @i += 1
    true
  end

  def valid?
    @program.size == @i
  end
end
