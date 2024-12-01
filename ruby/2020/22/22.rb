def hand(filename)
  lines = File.open(filename).readlines
  lines.map { |line| line.to_i }
end

hands = []

hands[0] = hand('22.input.1')
hands[1] = hand('22.input.2')

while !hands[0].empty? && !hands[1].empty?
  max = -1
  index_max = -1
  hands.each_index do |index|
    if hands[index][0] > max
      max = hands[index][0]
      index_max = index
    end
  end
  hands[index_max] << hands[index_max].shift
  hands[index_max] << hands[1 - index_max].shift
end

sum = 0

hands.each do |hand|
  hand.reverse!
  hand.each_index do |index|
    puts hand[index].to_s + ' ' + (index + 1).to_s
    sum += (index + 1) * hand[index]
  end
end

puts sum
