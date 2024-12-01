class Solver
  def initialize(file)
    data = File.open(file).readlines.collect { |l| l.strip }

    @points = data.filter { |l| l =~ /\d+,\d+/ }.collect { |l| l.split(',').collect { |n| n.to_i } }

    @instructions = data[@points.size + 1..].collect { |l| l[11..].split('=') }

    @direction = {}
    @direction['x'] = [-1, 1]
    @direction['y'] = [1, -1]

    @position = {}
    @position['x'] = 0
    @position['y'] = 1
  end

  def calc_fold(point, displacement)
    displacement - point
  end

  def do_fold(point, dir, displacement)
    if dir == 'x'
      point[0] = calc_fold(point[0], displacement)
    else
      point[1] = calc_fold(point[1], displacement)
    end
  end

  def fold
    instruction = @instructions.shift
    direction = instruction[0]
    value = instruction[1].to_i
    displacement = value * 2
    @points.filter { |p| p[@position[direction]] > value }.each { |p| do_fold(p, direction, displacement) }
    @points.uniq!

    @points.size
  end

  def fold_all
    fold until @instructions.empty?
  end

  def print
    max = 0
    @points.each do |p|
      max = p[0] if p[0] > max
      max = p[1] if p[1] > max
    end

    arr = Array.new(max) { Array.new(max, ' ') }

    @points.each do |p|
      arr[p[1]][p[0]] = '*'
    end

    arr.each do |l|
      p l.join
    end
  end
end

solver = Solver.new('13-input')
p solver.fold
solver.fold_all
solver.print
