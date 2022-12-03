#35784 too low
class Card
  def initialize(lines)
    @row_count = [0, 0, 0, 0, 0]
    @column_count = [0, 0, 0, 0, 0]
    @map = {}
    lines.each_with_index do |line, row|
      line.split(' ').each_with_index do |number, column|
        @map[number.strip] = [row, column]
      end
    end
  end

  # returns true if bingo, false otherwise
  def accept(number)
    return false unless @map.include? number

    row, column = @map[number]
    @row_count[row] += 1
    @column_count[column] += 1
    return true if @row_count[row] == 5 || @column_count[column] == 5
    false
  end

  def score(draw, last_number)
    sum = @map.each_key.reduce {|x, y| x.to_i + y.to_i}
    draw.each do |number|
      sum -= number.to_i if @map.include? number
      break if number == last_number
    end
    sum * last_number.to_i
  end

  def reset
    @row_count = [0, 0, 0, 0, 0]
    @column_count = [0, 0, 0, 0, 0]
  end
end

lines = File.open('4-input').readlines.collect {|l| l.strip }

draw = lines.shift.split(',')
lines.shift #remove empty line

cards = []
while lines.size > 4
  cards << Card.new(lines.shift(5))
  lines.shift #remove empty line
end

last_number = nil
winner_card = nil
has_winner = false
draw.each do |number|
  cards.each do |card|
    if card.accept(number)
      last_number = number
      winner_card = card
      has_winner = true
      break
    end
  end
  break if has_winner
end

puts winner_card.score(draw, last_number)

cards.each {|card| card.reset}

draw.each do |number|
  cards_to_remove = []
  cards.each do |card|
    if card.accept(number)
      cards_to_remove << card
    end
  end

  if !cards_to_remove.empty? && cards.size == 1
    last_number = number
    break
  end
  cards = cards.difference(cards_to_remove)
end
puts cards[0].score(draw, last_number)
