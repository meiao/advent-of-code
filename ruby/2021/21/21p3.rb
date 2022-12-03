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

  def pos
    @pos
  end

  def score
    @score
  end

  def clone
    Player.new(@pos, @score)
  end
end

class Game
  @@cache = {}
  @@dice_count = {
    3 => 1,
    4 => 3,
    5 => 6,
    6 => 7,
    7 => 6,
    8 => 3,
    9 => 1
  }
  def self.play(players, turn)
    other = players[!turn]
    if other.score >= 21
      return {
        turn => 0,
        !turn => 1
      }
    end

    key = [cur.pos, cur score, other.pos, other.score]
    if @@cache.has_key?
      cached = @@cache[key]
      return {
        turn => cached[turn],
        !turn => cached[!turn]
      }
    end

    cur = players[turn]
    win_count = Hash.new(0)
    @@dice_count.each_pair do |sum, mult|
      clone = cur.clone
      clone.walk(sum)

      next_players = {
        !turn => players[!turn],
        turn => clone
      }
      wins = Game.play(next_players, !turn)
      win_count[turn] += mult * wins[turn]
      win_count[!turn] += mult * wins[!turn]
    end
    @@cache[key] = win_count
    win_count
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
Game.play(players, true)
p Game.wins
