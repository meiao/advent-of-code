class Processor
  def initialize
    @map = {}
    lines = File.open('9.input').readlines

    lines.each do |line|
      places, distance = line.split(' = ')
      place1, place2 = places.split(' to ')
      @map[place1] = {} if @map[place1].nil?
      @map[place2] = {} if @map[place2].nil?
      @map[place1][place2] = distance.to_i
      @map[place2][place1] = distance.to_i
    end
  end

  def min_trip(current_place, remaining_places)
    return [0, 0] if remaining_places.empty?

    min = 10_000_000_000_000_000_000_000_000_000_000_000
    max = 0
    remaining_places.each do |next_place|
      places_to_check = Array.new(remaining_places)
      places_to_check.delete(next_place)
      min_cost, max_cost = min_trip(next_place, places_to_check)
      min_cost += @map[current_place][next_place]
      max_cost += @map[current_place][next_place]
      min = min_cost if min_cost < min
      max = max_cost if max_cost > max
    end
    [min, max]
  end

  def calculate_min_trip
    min = 1_000_000_000_000_000_000_000_000_000_000_000
    max = 0
    @map.keys.each do |place|
      remaining_places = @map.keys
      remaining_places.delete(place)
      min_cost, max_cost = min_trip(place, remaining_places)
      min = min_cost if min_cost < min
      max = max_cost if max_cost > max
    end
    puts min
    puts max
  end
end

Processor.new.calculate_min_trip
