class Solver
  #solves the problem by rotating the plane so you always walk east.
  # this algorithm is not really suited to answer part 2
  def solve(input)
    input = input.split(', ')
    pos = [0, 0]
    until input.empty?
      cmd = input.shift
      pos = rotate(pos, cmd)
      pos[0] += cmd[1..].to_i
    end
    return pos[0].abs + pos[1].abs
  end

  # return the new current position in the rotated plane
  def rotate(pos, cmd)
    if cmd[0] == 'R'
      return [pos[1], -pos[0]]
    else
      return [-pos[1], pos[0]]
    end
  end
end
