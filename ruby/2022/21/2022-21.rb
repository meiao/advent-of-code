#!/usr/local/bin/ruby

# This program answers Advent of Code 2022 day 21
#
# This version ran in
#
# Author::    Andre Onuki
# License::   GPL3
class Solver
  def initialize(input)
    @monkeys = {}
    input.each do |line|
      name, expr = line.strip.split(': ')
      expr = expr.to_i if expr.index(/\d+/) == 0
      @monkeys[name] = expr
    end
  end

  def solve
    calculate('root')
  end

  def calculate(name)
    return @monkeys[name] if @monkeys[name].is_a?(Numeric)

    name1, op, name2 = @monkeys[name].split(' ')
    value1 = calculate(name1)
    value2 = calculate(name2)
    @monkeys[name] = apply(value1, op, value2)
  end

  def apply(v1, op, v2)
    case op
    when '+'
      v1 + v2
    when '-'
      v1 - v2
    when '*'
      v1 * v2
    when '/'
      v1 / v2
    end
  end

  def solve2
    @monkeys['humn'] = '(humn)'
    name1, _, name2 = @monkeys['root'].split(' ')

    value1 = calculate2(name1)
    value2 = calculate2(name2)
    p value1
    p value2
    return decalculate(value1, value2) if value1.is_a?(Numeric)

    decalculate(value2, value1)
  end

  def calculate2(name)
    return @monkeys[name] if @monkeys[name].is_a?(Numeric)
    return '(humn)' if name == 'humn'

    name1, op, name2 = @monkeys[name].split(' ')
    value1 = calculate2(name1)
    value2 = calculate2(name2)
    return @monkeys[name] = apply(value1, op, value2) if value1.is_a?(Numeric) && value2.is_a?(Numeric)

    @monkeys[name] = "(#{value1} #{op} #{value2})"
  end

  def decalculate(number, humn)
    return number if humn == '(humn)'

    match = humn.match(%r{^\((\(.*\)) ([+\-*/]) (\d+)\)$})
    return decalculate(deapply(number, match[2], match[3].to_i), match[1]) unless match.nil?

    match = humn.match(%r{^\((\d+) ([+\-*/]) (\(.*\))\)$})
    return decalculate(reverse_apply(number, match[2], match[1].to_i), match[3]) unless match.nil?

    throw Error('One regex shoulda matched')
  end

  def deapply(v1, op, v2)
    case op
    when '+'
      v1 - v2
    when '-'
      v1 + v2
    when '*'
      v1 / v2
    when '/'
      v1 * v2
    end
  end

  def reverse_apply(v1, op, v2)
    case op
    when '+'
      v1 - v2
    when '-'
      (v1 - v2) * -1
    when '*'
      v1 / v2
    when '/'
      v2 / v1
    end
  end
end
