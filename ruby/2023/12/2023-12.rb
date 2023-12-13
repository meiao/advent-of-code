#!/usr/local/bin/ruby

# This program answers Advent of Code 2023 day 12
#
# Author::    Andre Onuki
# License::   GPL3
class Solver
  def solve(input)
    input.map do |line|
      data = line.split
      arrangements(data[0], data[1])
    end.sum
  end

  def arrangements(springs, numbers)

    numbers = numbers.split(',').map{|n| n.to_i}
    springs = springs.split('')
    springs, numbers = minimize(springs, numbers)
    return 1 if numbers.empty?

    expected_broken = numbers.sum - springs.count('#')
    unknown = springs.count('?')
    base = 2**unknown
    sum = 0
    (2**unknown).times do |i|
      sub = (base + i).to_s(2).tr('01', '.#').split('')[1..-1]
      next if sub.count('#') != expected_broken
      sum += 1 if verify(springs, numbers, sub)
    end
    sum
  end


  def minimize(springs, numbers)
    changed = true
    while changed
      changed = false
      springs = clean_multiple_working(springs)
      remove_operational_from_edges(springs)
      changed ||= force_operational_on_max(springs, numbers)

      # reversible operations
      changed ||= remove_longest_from_start(springs, numbers)
      break if numbers.empty?
      changed ||= remove_leading_question(springs, numbers)
      changed ||= remove_leading_question_small(springs, numbers)
      changed ||= force_leading_broken(springs, numbers)
      changed ||= remove_broken(springs, numbers)
      break if numbers.empty?
      springs.reverse!
      numbers.reverse!
      changed ||= remove_longest_from_start(springs, numbers)
      break if numbers.empty?
      changed ||= remove_leading_question(springs, numbers)
      changed ||= remove_leading_question_small(springs, numbers)
      changed ||= force_leading_broken(springs, numbers)
      changed ||= remove_broken(springs, numbers)
      break if numbers.empty?
      springs.reverse!
      numbers.reverse!
    end
    [springs, numbers]
  end

  def clean_multiple_working(springs)
    springs.join.gsub(/\.+/, '.').split('')
  end

  def remove_operational_from_edges(springs)
    springs.shift if springs[0] == '.'
    springs.pop if springs[-1] == '.'
  end

  def remove_broken(springs, numbers)
    return false if springs[0] != '#'
    springs.shift(numbers.shift + 1)
    true
  end

  def remove_longest_from_start(springs, numbers)
    max = numbers.max
    return false if numbers[0] != max || numbers.count(max) > 1
    index = springs.join.index('#' * max)
    return false if index == nil
    springs.shift(index + max)
    numbers.shift
    true
  end

  def force_operational_on_max(springs, numbers)
    max = numbers.max
    offset = 0
    changed = false
    while true
      index = springs.join.index('#' * max, offset)
      return changed if index == nil

      if index > 0 && springs[index - 1] == '?'
        springs[index - 1] = '.'
        changed = true
      end
      if springs[index + max] == '?'
        springs[index + max] = '.'
        changed = true
      end
      offset = index + 1
    end
  end

  def remove_leading_question(springs, numbers)
    return false if springs[0] != '?'
    i = 0
    while springs[i] == '?' && i < numbers[0] do
      i += 1
    end
    changed = false
    while springs[i] == '#' do
      if i < numbers[0]
        i += 1
      else
        springs.shift
        changed = true
      end
    end
    changed
  end

  def remove_leading_question_small(springs, numbers)
    i = 0
    while true
      return false if springs[i] == '#'
      break if springs[i] == '.'
      break if springs[i] == nil
      i += 1
    end

    if i < numbers[0]
      springs.shift(i+1)
      return true
    end

    false
  end

  def force_leading_broken(springs, numbers)
    found_broken = false
    changed = false
    numbers[0].times do |i|
      if found_broken
        if springs[i] == '?'
          springs[i] = '#'
          changed = true
        end
      elsif springs[i] == '#'
        found_broken = true
      end
    end

    if found_broken
      i = numbers[0]
      while springs[i] == '?'
        return changed if i > numbers[0] * 2 - 2
        i += 1
      end
      return changed if springs[i] == '#'
      i -= 1
      found_broken = false
      numbers[0].times do |j|
        if found_broken
          if springs[i-j] == '?'
            springs[i-j] = '#'
            changed = true
          end
        elsif springs[i-j] == '#'
          found_broken = true
        end
      end
    end
    changed
  end

  def verify(springs, numbers, sub)
    str = ""
    springs.each do |c|
      if c == '?'
        str << sub.shift
      else
        str << c
      end
    end
    calculated = str.gsub(/\.+/, '.').split('.').map{|broken| broken.size}
    calculated.shift if calculated[0] == 0
    calculated.pop if calculated[-1] == 0
    calculated == numbers
  end

  def solve2(input)
    input.map do |line|
      data = line.split
      arrangements(((data[0] + '?')*5)[0..-2], ((data[1] + ',')*5)[0..-2])
    end.sum
  end
end
