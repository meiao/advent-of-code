lines = File.open('11.input').readlines
h = lines.size
w = lines[0].size
matrix = {}

lines.each_index do |i|
  line = lines[i].strip.split('')
  line.each_index do |j|
    matrix[[i, j]] = line[j]
  end
end

def next_matrix(matrix)
  next_matrix = {}
  matrix.keys.each do |pos|
    next_matrix[pos] = if matrix[pos] == '#'
                         next_occupied(matrix, pos)
                       elsif matrix[pos] == 'L'
                         next_empty(matrix, pos)
                       else
                         '.'
                       end
  end
  next_matrix
end

def next_element(matrix, pos, dir)
  next_pos = Array.new(pos)
  while true
    next_pos[0] += dir[0]
    next_pos[1] += dir[1]
    return matrix[next_pos] if matrix[next_pos] != '.'
  end
end

def next_occupied(matrix, pos)
  around = 0
  [-1, 0, 1].each do |x1|
    [-1, 0, +1].each do |y1|
      next if x1 == 0 && y1 == 0

      around += 1 if next_element(matrix, pos, [x1, y1]) == '#'
    end
  end
  return '#' if around < 5

  'L'
end

def next_empty(matrix, pos)
  around = 0
  [-1, 0, 1].each do |x1|
    [-1, 0, +1].each do |y1|
      next if x1 == 0 && y1 == 0

      around += 1 if next_element(matrix, pos, [x1, y1]) == '#'
    end
  end
  return '#' if around == 0

  'L'
end

def count(matrix)
  matrix.values.count('#')
end

while true
  matrix2 = next_matrix(matrix)
  (0..h).each do |y|
    (0..w).each do |x|
      print(matrix2[[x, y]])
    end
    puts
  end
  if matrix2 == matrix
    puts count(matrix2)
    break
  else
    matrix = matrix2
  end
end
