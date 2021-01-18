lines = File.open('14.input.parsed').readlines

class Reindeer
  def initialize(name, speed, fly_time, rest_time)
    @name = name
    @speed = speed
    @fly_time = fly_time
    @cycle_duration = rest_time + fly_time
    @distance = 0
    @points = 0
  end

  def dist
    return @distance
  end

  def race(seconds)
    cycles = seconds / @cycle_duration
    remaining = [seconds - cycles * @cycle_duration, @fly_time].min
    @distance = (cycles * @fly_time + remaining) * @speed
    return @distance
  end

  def win_round()
    @points += 1
  end

  def points()
    return @points
  end
end

reindeers = {}
lines.each do |line|
  name, speed, fly_time, rest_time = line.split(' ')
  reindeers[name] = Reindeer.new(name, speed.to_i, fly_time.to_i, rest_time.to_i)
end

# part 1

race_length = 2503
max = ['', 0]
reindeers.keys.each do |name|
  reindeer = reindeers[name]
  dist = reindeer.race(race_length)
  if dist > max[1]
    max[0] = name
    max[1] = dist
  end
end

puts max


# part 2

(1..race_length).each do |t|
  puts t
  max = ['', 0]
  reindeers.keys.each do |name|
    reindeer = reindeers[name]
    dist = reindeer.race(t)
    if dist > max[1]
      max[0] = name
      max[1] = dist
    end
  end
  reindeers.values.filter{|r| r.dist() == max[1]}.each{|r| r.win_round()}
end

puts reindeers.values.map{|r| r.points}.max
