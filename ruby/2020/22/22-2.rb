
def read_hand(filename)
  lines = File.open(filename).readlines
  return lines.map{|line| line.to_i}
end

hands = []

hands[0] = read_hand('22.input.1')
hands[1] = read_hand('22.input.2')

def winner(hands)
  hands.each_index do |index|
    return index if !hands[index].empty?
  end
end

def copy(hands)
  new_hands = []
  hands.each do |hand|
    new_hands << Array.new(hand)
  end
  return new_hands
end

def over(hands)
  hands.each do |hand|
    return true if hand.empty?
  end
  return false
end

def can_play_recur(hands)
  hands.each do |hand|
    return false if hand.size <= hand[0]
  end
  return true
end

def play_recur(hands)
  next_hands = []
  next_hands << Array.new(hands[0][1..hands[0][0]])
  next_hands << Array.new(hands[1][1..hands[1][0]])
  return winner(play(next_hands))
end

def play(hands)
  seen_hands = {}

  while !over(hands)
    if seen_hands[hands]
      hands[1] = []
      return hands
    end

    seen_hands[copy(hands)] = true

    winner_index = -1
    if can_play_recur(hands)
      winner_index = play_recur(hands)
    else
      max = -1
      hands.each_index do |index|
        if hands[index][0] > max
          max = hands[index][0]
          winner_index = index
        end
      end
    end

    hands[winner_index] << hands[winner_index].shift
    hands[winner_index] << hands[1 - winner_index].shift
  end
  return hands
end


hands = play(hands)

puts hands.to_s
sum = 0

hands.each do |hand|
  hand.reverse!
  hand.each_index do |index|
    sum += (index+1) * hand[index]
  end
end

puts sum
