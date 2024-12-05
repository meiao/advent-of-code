#!/usr/local/bin/ruby

# This program answers Advent of Code 2024 day 05
#
# Author::    Andre Onuki
# License::   GPL3
class Solver
  def solve(input)
    rules, updates = input.join.split("\n\n").map { |data| data.split("\n") }

    rule_map = make_rule_map(rules)

    updates.map { |update| update.split(',') }
           .filter { |update| ordered(update, rule_map) }
           .map { |update| update[update.length / 2].to_i }
           .sum
  end

  def make_rule_map(rules)
    # the values are the pages that must come after the key
    rule_map = Hash.new { |map, key| map[key] = [] }
    rules.each do |rule|
      page, after = rule.split('|')
      rule_map[page] << after
    end
    rule_map
  end

  def ordered(update, rule_map)
    (1..(update.length - 1)).each do |i|
      # the if statement checks if there is any page before the i-th
      # that must come after the i-th
      return false if update[0..(i - 1)].intersect?(rule_map[update[i]])
    end
    true
  end

  def solve2(input)
    rules, updates = input.join.split("\n\n").map { |data| data.split("\n") }

    rule_map = make_rule_map(rules)

    updates.map { |update| update.split(',') }
           .filter { |update| !ordered(update, rule_map) }
           .map { |update| quicksort(update, rule_map) }
           .map { |update| update[update.length / 2].to_i }
           .sum
  end

  # this most likely has a worse O() than quicksort
  # but it orders the elements using the same idea
  def quicksort(update, rule_map)
    return update if update.size < 2

    page = update.shift
    # get pages that must come after the page
    after = update.intersection(rule_map[page])
    # any other page must come before
    before = update - after
    # divide and conquer
    fix_order(before, rule_map).push(page).concat(fix_order(after, rule_map))
  end
end
