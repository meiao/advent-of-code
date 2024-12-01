class Dice
  def initialize
    @cur = 1
    @roll_count = 0
  end

  def roll
    @roll_count += 3
    v = @cur * 3 + 3
    @cur += 3
    if @cur > 100
      @cur -= 100
      v -= (@cur - 1) * 100
    end
    v
  end

  attr_reader :roll_count
end

class Player
  def initialize(pos)
    @pos = pos
    @score = 0
  end

  def walk(steps)
    @pos += steps
    @pos %= 10 if @pos > 10
    @pos = 10 if @pos == 0
    @score += @pos
  end

  attr_reader :score
end

class Game
  def initialize(pos1, pos2)
    @players = {}
    @players[true] = Player.new(pos1)
    @players[false] = Player.new(pos2)
  end

  def play
    dice = Dice.new
    turn = true
    while @players[true].score < 1000 && @players[false].score < 1000
      @players[turn].walk(dice.roll)
      turn = !turn
    end
    p @players
    p dice
    @players[turn].score * dice.roll_count
  end
end

p Game.new(8, 10).play
