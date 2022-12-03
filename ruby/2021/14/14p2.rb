class Solver

  def initialize(file, max_depth)
    data = File.open(file).readlines.collect{|l| l.strip}

    @base = data.shift
    data.shift # removes empty line

    @transformations = {}
    @transformations.default = ''
    data.each do |l|
      key, value = l.split(' -> ')
      @transformations[key] = value
    end

    @max_depth = max_depth

    @count = {}
    @count.default = 0
  end

  def calc(str, depth)
    return if depth >= @max_depth
    c = @transformations[str]
    @count[c] += 1
    calc(str[0] + c, depth + 1)
    calc(c + str[1], depth + 1)
    if depth < @min_depth
      p depth
      p Time.now.to_i - @start
      @min_depth = depth
    end
  end

  def solve
    @start = Time.now.to_i
    (@base.length - 1).times do |i|
      @min_depth = @max_depth
      calc(@base[i..i+1], 0)
      p i
    end
    @base.each_char do |c|
      @count[c] += 1
    end

    v = @count.values.sort
    v[-1] - v[0]
  end
end

solver = Solver.new('14-input', 40)
p solver.solve
