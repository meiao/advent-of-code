#!/usr/local/bin/ruby

# This program answers Advent of Code 2023 day 07
#
# Author::    Andre Onuki
# License::   GPL3
class Solver
  def solve(input)
    hands = input.map { |line| parse(line) }.sort_by { |hand| [hand[2], hand[0]] }
    sum = 0
    hands.size.times do |i|
      sum += (i + 1) * hands[i][1]
    end
    sum
  end

  def parse(line)
    cards, bid = line.split(' ')
    [cards_to_i(cards), bid.to_i, eval_cards(cards)]
  end

  def cards_to_i(cards)
    cards.split('').map do |c|
      case c
      when 'A'
        14
      when 'K'
        13
      when 'Q'
        12
      when 'J'
        11
      when 'T'
        10
      else
        c.to_i
      end
    end
  end

  def eval_cards(cards)
    copies = Hash.new(0)
    cards.each_char { |c| copies[c] += 1 }
    return copies.values if copies.size == 1

    copies.values.sort[-2..-1].reverse
  end

  def solve2(input)
    hands = input.map { |line| parse2(line) }.sort_by { |hand| [hand[2], hand[0]] }
    sum = 0
    hands.size.times do |i|
      sum += (i + 1) * hands[i][1]
    end
    sum
  end

  def parse2(line)
    cards, bid = line.split(' ')
    [cards_to_i2(cards), bid.to_i, eval_cards2(cards), cards]
  end

  def cards_to_i2(cards)
    cards.split('').map do |c|
      case c
      when 'A'
        14
      when 'K'
        13
      when 'Q'
        12
      when 'J'
        1
      when 'T'
        10
      else
        c.to_i
      end
    end
  end

  def eval_cards2(cards)
    copies = Hash.new(0)
    cards.each_char { |c| copies[c] += 1 }
    jokers = copies.delete('J')
    return [5] if copies.size <= 1

    value = copies.values.sort[-2..-1].reverse
    return value if jokers.nil?

    value[0] += jokers
    value
  end
end
