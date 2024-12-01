class Solver
  def initialize(file)
    data = File.open(file).readlines.collect { |l| l.strip }

    @base = data.shift
    data.shift # removes empty line

    @transformations = {}
    @transformations.default = ''
    data.each do |l|
      key, value = l.split(' -> ')
      @transformations[key] = value
    end

    @count = {}
    @count.default = 0
  end

  def step(pairs, sum)
    next_pairs = {}
    next_pairs.default = 0
    pairs.each_pair do |str, count|
      next_char = @transformations[str]
      sum[next_char] += count
      next_pairs[str[0] + next_char] += count
      next_pairs[next_char + str[1]] += count
    end
    next_pairs
  end

  def solve(steps)
    sum = {}
    sum.default = 0

    current_pairs = {}
    current_pairs.default = 0
    (@base.length - 1).times do |i|
      current_pairs[@base[i..i + 1]] += 1
    end

    @base.each_char do |c|
      sum[c] += 1
    end

    p current_pairs
    steps.times do
      current_pairs = step(current_pairs, sum)
      p current_pairs
    end

    v = sum.values.sort
    v[-1] - v[0]
  end
end

solver = Solver.new('14-input')
p solver.solve(40)
