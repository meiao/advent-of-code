class Processor
  def initialize
    lines = File.open('17.input').readlines
    @matrix = {}

    @h = lines.size
    @w = lines[0].strip.size

    lines.each_index do |y|
      lines[y].split('').each_index do |x|
        @matrix[[x, y, 0]] = true if lines[y][x] == '#'
      end
    end
  end

  def calc(x, y, z, _cycle)
    sum = 0
    [x - 1, x, x + 1].each do |x1|
      [y - 1, y, y + 1].each do |y1|
        [z - 1, z, z + 1].each do |z1|
          sum += 1 if @matrix[[x1, y1, z1.abs]]
        end
      end
    end
    if @matrix[[x, y, z]]
      [3, 4].include?(sum)
    else
      sum == 3
    end
  end

  def cycle(i)
    next_matrix = {}
    x_range = [0, 0]
    y_range = [0, 0]
    @matrix.keys.each do |key|
      x, y, = key
      x_range[0] = x if x < x_range[0]
      x_range[1] = x if x > x_range[1]
      y_range[0] = y if y < y_range[0]
      y_range[1] = y if y > y_range[1]
    end
    x_range[0] -= 1
    x_range[1] += 1
    y_range[0] -= 1
    y_range[1] += 1

    (x_range[0]..x_range[1]).each do |x|
      (y_range[0]..y_range[1]).each do |y|
        (i + 1).times do |z|
          next_matrix[[x, y, z]] = true if calc(x, y, z, i)
        end
      end
    end
    @matrix = next_matrix
  end

  def part1
    6.times do |i|
      cycle(i + 1)
    end

    sum = @matrix.size
    @matrix.keys.each do |key|
      _, _, z = key
      sum += 1 if z != 0
    end
    puts sum
  end
end

Processor.new.part1
