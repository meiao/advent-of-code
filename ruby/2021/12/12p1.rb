class Solver

  def initialize(file)
    data = File.open(file).readlines.collect {|l| l.strip.split('-') }
    @map = Hash.new {|hash, key| hash[key] = []}
    data.each do |d|
      @map[d[0]] << d[1]
      @map[d[1]] << d[0]
    end

    @stack = []
  end

  def calculate()
    @stack << 'start'
    visit()
  end

  def is_lower?(str)
    str == str.downcase
  end

  def visit()
    cur = @stack[-1]
    return 1 if cur == 'end'

    sum = 0
    @map[cur].each do |next_node|
      next if is_lower?(next_node) && @stack.include?(next_node)
      @stack << next_node
      sum += visit()
      @stack.pop
    end
    sum
  end

end

p Solver.new('12-input').calculate()
