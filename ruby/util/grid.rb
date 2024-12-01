# Class that converts x,y coordinates into a list of strings.
# y = 0 is the first line, y = 1 is the second line, and so on
class Grid
  # data should be an array of strings
  # numbering starts with 0 and follows a text document
  # 0 being the first line, 1 being the line below it.
  def initialize(data, wall = '#')
    @data = data
    @wall = wall
  end

  # coord should be an array with 2 numbers
  # [x,y]
  def [](coord)
    @data[coord[1]][coord[0]]
  end

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
