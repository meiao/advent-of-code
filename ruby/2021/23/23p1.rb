class Amphipod
  def self.from_array(arr)
    arr.collect{|c| Amphipod.new(c, 0)}
  end

  def initialize(type)
    @type = type
  end

  def type
    @type
  end

  def to_s
    @type
  end

  def ==(other)
    @type == other.type
  end
end

class Map
  def self.from_array(rooms)
    hallway = Array.new(11)
    rooms = {
      'a' => Amphipod.from_array(rooms[0]),
      'b' => Amphipod.from_array(rooms[1]),
      'c' => Amphipod.from_array(rooms[2]),
      'd' => Amphipod.from_array(rooms[3])
    }
    # simplifying the cost to move out of the room
    rooms.values.each do |room|
      room[1].walk(1)
    end
    Map.new(hallway, rooms)
  end

  def initialize(hallway, rooms)
    @hallway = hallway
    @rooms = rooms
  end

  def hallway
    @hallway
  end

  def rooms
    @rooms
  end

  def clone()
    Map.new(Array.new(@hallway), @rooms.merge)
  end

  def print
    puts '#############'
    print_hallway()
    print_rooms(0)
    print_rooms(1)
    puts '  #########  '
  end

  def print_hallway
    hallway = '#'
    11.times do |i|
      h = @hallway[i]
      if h.nil?
        hallway << '.'
      else
        hallway << h.to_s
      end
    end
    hallway << '#'
    puts hallway
  end

  def print_rooms(n)
    line = '  #'
    ['a', 'b', 'c', 'd'].each do |room|
      if @rooms[room][n].nil?
        line << '.'
      else
        line << @rooms[room][n].to_s
      end
      line << '#'
    end
    puts line
  end

end


class Solver
  @@cache = {}
  @@cost_by_type = {
    'a' => 1,
    'b' => 10,
    'c' => 100,
    'd' => 1000
  }
  @@room_positions = {
    'a' => 2,
    'b' => 4,
    'c' => 6,
    'd' => 8
  }
  @@stopping_places = [1, 3, 5, 7, 9, 10, 0]

  def self.key(map)
    [map.hallway, map.rooms]
  end

  def self.solve(base_map)
    key = Solver.key(base_map)
    return @@cache[key] if @@cache.has_key?(key)

    if Solver.done?(base_map)
      return @@cache[key] = 0
    end

    min = 100000000000
    map = base_map.clone
    cost = Solver.move_all_from_hallway(map)
    cost += Solver.move_all_from_rooms(map)



    @@cache[key] = min
  end

  def self.move_all_from_hallway(map)
    cost = 0
    while true
      break if map.hallway.compact.empty?
      moved = false

      @@stopping_places.each do |i|
        amphipod = map.hallway[i]
        next if amphipod.nil?

        if Solver.can_go_home?(map, i, type)
          moved = true
          map.hallway[i] = nil
          map.rooms[type] << amphipod
          steps = (i - @@room_positions[type]).abs + 1
          cost += @@cost_by_type[type] * steps
        end
      end

      break if !moved
    end
    cost
  end

  def self.move_all_from_rooms(map) # to rooms
    cost = 0
    while true
      moved = false

      map.rooms.each_pair do |type, room|
        next if room.empty? || room[0].type == type

        while true
          break if room.empty?
          amphipod = room[0]
          break if !Solver.can_go_home?(map, @@room_positions[type], amphipod.type)
          moved = true
          amphipod = room.shift
          map.rooms[type] << amphipod
          steps = (@@room_positions[amphipod.type] - @@room_positions[type]).abs + 2
          cost += @@cost_by_type[amphipod.type] * steps

        end
      end
      break if !moved
    end
    cost
  end

  def self.can_go_home?(map, i, type)
    first_in_room = map.rooms[type][0]
    return false if !first_in_room.nil? && first_in_room.type != type

    range = [i, @@room_positions[type]].sort
    map.hallway[range[0]..range[1]].compact.empty?
  end

end

data = IO.readlines('23-input-small').collect{|l| l.strip.split('')}

base_map = Map.from_array(data)

Solver.solve(base_map)
