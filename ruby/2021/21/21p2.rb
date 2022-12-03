# ran in 18m20.904s
class Player
  def initialize(pos, score)
    @pos = pos
    @score = score
  end

  def walk(steps)
    @pos += steps
    @pos = @pos % 10 if @pos > 10
    @pos = 10 if @pos == 0
    @score += @pos
  end

  def score
    @score
  end

  def clone
    Player.new(@pos, @score)
  end
end

class Game
  @@wins = Hash.new(0)
  @@dice_count = {
    3 => 1,
    4 => 3,
    5 => 6,
    6 => 7,
    7 => 6,
    8 => 3,
    9 => 1
  }
  def self.play(players, turn, mult)
    players.each_pair do |key, player|
      if player.score >= 21
        @@wins[key] += mult
        p @@wins
        return
      end
    end

    @@dice_count.each_pair do |sum, dice_mult|
      cur_player = players[turn]
      clone = cur_player.clone
      clone.walk(sum)

      next_players = {
        !turn => players[!turn],
        turn => clone
      }
      Game.play(next_players, !turn, dice_mult * mult)
    end
  end

  def self.wins
    @@wins
  end

end

p1 = Player.new(8, 0)
p2 = Player.new(10, 0)
players = {
  true => p1,
  false => p2
}
Game.play(players, true, 1)
p Game.wins
