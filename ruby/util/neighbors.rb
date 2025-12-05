module HasNeighbors
  # returns an array with the 8 neighbors of a position in the grid
  def neighbors(pos)
    NEIGHBORS.map { |dir| [pos[0] + dir[0], pos[1] + dir[1]] }
  end

  NEIGHBORS = [[-1, 1],  [0, 1],  [1, 1],
               [-1, 0],           [1, 0],
               [-1, -1], [0, -1], [1, -1]].freeze
end
