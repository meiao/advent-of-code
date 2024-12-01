class Solver
  def initialize(file)
    data = File.open(file).readlines.collect { |l| l.strip }

    @base = data.shift.split('')
    data.shift # removes empty line

    @transformations = {}
    @transformations.default = ''
    data.each do |l|
      key, value = l.split(' -> ')
      @transformations[key.split('')] = value
    end
  end

  def print
    map = {}
    map.default = 0
    @base.each do |c|
      map[c] += 1
    end
    v = map.values.sort!
    p @base
    p v[-1] - v[0]
  end

  def do_step
    acc = []
    until @base.empty?
      new_char = @transformations[@base[0..1]]
      acc << @base.shift
      acc << new_char if new_char != ''
    end

    @base = acc
  end

  def step(n)
    n.times do |i|
      p i
      do_step
      p @base.length
    end
  end
end

solver = Solver.new('14-input')
solver.step(40)
solver.print
