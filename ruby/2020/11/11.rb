lines = File.open('11.input').readlines

matrix = []

lines.each do |line|
  matrix << line.strip.split('')
end


def next_matrix(matrix)
  next_matrix = []
  matrix.each_index do |x|
    next_matrix << []
    matrix[x].each_index do |y|
      if matrix[x][y] == '#'
        next_matrix[x][y] = next_occupied(matrix, x, y)
      elsif matrix[x][y] == 'L'
        next_matrix[x][y] = next_empty(matrix, x, y)
      else
        next_matrix[x][y] = '.'
      end
    end
  end
  return next_matrix
end

def next_occupied(matrix, x, y)
  around = -1
  [x-1, x ,x+1].each do |x1|
    [y-1, y ,y+1].each do |y1|
      next if x1 < 0 || x1 >= matrix.size
      next if y1 < 0 || y1 >= matrix[x].size
      around += 1 if matrix[x1][y1] == '#'
    end
  end
  return '#' if around < 4
  return 'L'
end

def next_empty(matrix, x, y)
  around = 0
  [x-1, x ,x+1].each do |x1|
    [y-1, y ,y+1].each do |y1|
      next if x1 < 0 || x1 >= matrix.size
      next if y1 < 0 || y1 >= matrix[x].size
      around += 1 if matrix[x1][y1] == '#'
    end
  end
  return '#' if around == 0
  return 'L'
end

def count(matrix)
  matrix.map{|line| line.count('#')}.sum
end

while true
  matrix2 = next_matrix(matrix)
  if matrix2 == matrix
    puts count(matrix2)
    break
  else
    matrix = matrix2
  end
end
