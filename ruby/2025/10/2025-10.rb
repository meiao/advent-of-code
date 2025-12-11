#!/usr/local/bin/ruby

# This program answers Advent of Code 2025 day 10
#
# Author::    Andre Onuki
# License::   GPL3

require_relative '../../util/sumarray'
class Solver

  def solve(input)
    input.map{|line|clicks_to_turn_on(line)}
         .sum
  end

  def clicks_to_turn_on(line)
    final_state, buttons, joltage = decode_machine(line)
    seen_states = Hash.new(false)
    initial_state = Array.new(final_state.size, false)
    return 0 if final_state == initial_state
    seen_states[initial_state] = true
    clicks = 0
    loop do
      clicks += 1
      seen_states.keys.each do |state|
        buttons.each do |button|
          new_state = press(state, button)
          return clicks if final_state == new_state
          seen_states[new_state] = true
        end
      end
    end
  end

  def decode_machine(line)
    parts = line.split(' ')

    final_state = parts[0][1..-2].chars.map{|c| c == '#'}

    buttons = parts[1..-2].map{|buttons| buttons[1..-2].split(',').map(&:to_i)}

    joltage = parts[-1][1..-2].split(',').map(&:to_i)

    [final_state, buttons, joltage]
  end

  def press(status, button)
    new_status = status.clone
    button.each do |i|
      new_status[i] ^= true
    end
    new_status
  end


  def solve2(input)
    input.map{|line|clicks_to_joltage(line)}
         .sum
  end

  def clicks_to_joltage(line)
    p line
    final_state, buttons, joltage = decode_machine(line)
    min_clicks_joltage(Array.new(joltage.size, 0), buttons, joltage.sum, 0, joltage)
  end

  # slightly smart brute force. Will try to find the easiest index to check,
  # then recursively will try the other indexes. Linear programming would solve much quicker.
  def min_clicks_joltage(state, buttons, min, clicks, joltage)
    return clicks if state == joltage
    return min unless smaller?(state, joltage)
    return min unless viable?(state, joltage, buttons)

    index_to_tackle = easiest_index(buttons, state, joltage)
    buttons_for_i = buttons.select{|b| b.include? index_to_tackle}
    clicks_for_i = joltage[index_to_tackle] - state[index_to_tackle]
    return min if clicks + clicks_for_i >= min

    combinations = SumArray.new(clicks_for_i, buttons_for_i.size)
    next_buttons = buttons - buttons_for_i
    combinations.each do |presses|
      next_state = state.clone
      buttons_for_i.zip(presses).each do |button_presses|
        press2(next_state, button_presses[0], button_presses[1])
      end
      min = min_clicks_joltage(next_state, next_buttons, min, clicks + clicks_for_i, joltage)
    end
    min
  end

  # checks whether the remaining buttons can change the indexes that still require changing
  def viable?(state, final_state, buttons)
    needed = (0..(state.size() - 1)).select {|i| state[i] != final_state[i]}
    available = buttons.flatten.uniq
    needed.all?{|i| available.include?(i) }
  end

  # Checks that all indexes in the current state are smaller or equal the final state
  def smaller?(new_state, final_state)
    new_state.zip(final_state).all?{|counters| counters[0] <= counters[1]}
  end

  def press2(status, button, times)
    button.each do |i|
      status[i] += times
    end
  end

  # try to find an index that is only handled by one or two buttons.
  # if no such index, will try to solve the index that requires the least
  # clicks
  def easiest_index(buttons, status, joltage)
    tally = buttons.flatten.tally.to_a.sort{|a,b| a[1] <=> b[1]}[0]
    return tally[0] if tally[1] <= 2
    clicks_needed = joltage.zip(status).map{|v| v[0] - v[1]}
    min_clicks = clicks_needed.select{|clicks| clicks > 0}.min
    return clicks_needed.index(min_clicks)
  end

end
