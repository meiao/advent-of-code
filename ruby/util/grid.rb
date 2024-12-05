# Class that converts x,y coordinates into a list of strings.
# y = 0 is the first line, y = 1 is the second line, and so on
class Grid
  # data should be an array of strings
  # numbering starts with 0 and follows a text document
  # 0 being the first line, 1 being the line below it.
  def initialize(data, wall = '#')
    @data = data
    @wall = wall
    @limits = [@data[0].strip.length - 1, @data.length - 1]
  end

  # coord should be an array with 2 numbers
  # [x,y]
  def [](coord)
    return nil if coord[0] < 0 || coord[1] < 0 || coord[0] > @limits[0] || coord[1] > @limits[1]

    @data[coord[1]][coord[0]] # coord are inverted because of array of arrays
  end

  attr_reader :limits

  # step should be an array, with two arrays of two numbers
  # [[x0, y0], [x1, y1]]
  # |x0 -x1| + |y0 - y1| == 1
  def next_steps(previous, current)
    next_steps = []
    [[0, 1], [0, -1], [1, 0], [-1, 0]].each do |dir|
      next_step = [current[0] + dir[0], current[1] + dir[1]]
      next_steps << next_step if next_step != previous && self[next_step] != @wall
    end
    next_steps
  end
end

class Finder
  def initialize(grid)
    @grid = grid
  end

  def find4way(value)
    find([[0, 1], [0, -1], [1, 0], [-1, 0]], value)
  end

  def find8way(value)
    find([[0, 1], [0, -1], [1, 0], [-1, 0], [1, 1], [1, -1], [-1, 1], [-1, -1]], value)
  end

  def find(directions, value)
    results = []
    limits = @grid.limits
    (0..limits[0]).each do |x|
      (0..limits[1]).each do |y|
        results.concat(search_cell([x, y], directions, value))
      end
    end
    results
  end

  private

  def search_cell(cell, directions, value)
    return [] if @grid[cell] != value[0]

    results = []
    directions.each do |dir|
      results << [cell, dir] if contain?(cell, dir, value)
    end
    results
  end

  def contain?(cell, dir, value)
    @grid.limits
    value.each_with_index do |v, i|
      x = cell[0] + i * dir[0]
      y = cell[1] + i * dir[1]
      return false if @grid[[x, y]] != v
    end
    true
  end
end
