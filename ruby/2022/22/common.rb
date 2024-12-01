class Me
  attr_reader :cur_cell, :cur_dir

  def initialize(map)
    @cur_dir = Direction.map[:R]
    @map = map
    x = 0
    x += 1 while @map[[x, 0]].nil?
    @cur_cell = @map[[x, 0]]
  end

  def move(steps)
    next_state = @cur_cell.move(@cur_dir, steps)
    @cur_cell = next_state[0]
    @cur_dir = next_state[1]
  end

  def turn(direction)
    @cur_dir = @cur_dir.turn[direction]
  end
end

class Direction
  @@map = nil
  attr_reader :name, :dir, :turn, :value

  def initialize(name, dir, value)
    @name = name
    @dir = dir
    @value = value
    @turn = {}
  end

  def self.map
    return @@map unless @@map.nil?

    @@map = {
      R: Direction.new(:R, [1, 0], 0),
      D: Direction.new(:D, [0, 1], 1),
      L: Direction.new(:L, [-1, 0], 2),
      U: Direction.new(:U, [0, -1], 4)
    }
    map[:R].turn['R'] = map[:D]
    map[:R].turn['L'] = map[:U]
    map[:D].turn['R'] = map[:L]
    map[:D].turn['L'] = map[:R]
    map[:L].turn['R'] = map[:U]
    map[:L].turn['L'] = map[:D]
    map[:U].turn['R'] = map[:R]
    map[:U].turn['L'] = map[:L]
    map
  end
end

class Cell
  attr_reader :point

  def initialize(point, map)
    @point = point
    @map = map
    @next_cell = {}
  end

  def move(direction, steps)
    cur_cell = self
    steps.times do
      next_cell = cur_cell.move_single(direction)
      return [cur_cell, direction] if next_cell[0].is_a?(Wall)

      cur_cell = next_cell[0]
      direction = next_cell[1]
    end
    [cur_cell, direction]
  end

  def move_single(direction)
    return @next_cell[direction.name] unless @next_cell[direction.name].nil?

    next_point = [@point[0] + direction.dir[0], @point[1] + direction.dir[1]]
    set_next_cell(direction.name, @map[next_point], direction.name)
  end

  def set_next_cell(direction_name, cell, next_direction_name)
    next_dir = Direction.map[next_direction_name]
    @next_cell[direction_name] = [cell, next_dir]
  end
end

class Wall
  @@instance = Wall.new

  def self.instance
    @@instance
  end

  def set_next_cell(direction_name, cell, next_direction)
    # for comaptibility with Cell
  end
end
