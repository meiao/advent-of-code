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
    @stack << 'start'
    visit()
  end

  def is_lower?(str)
    str == str.downcase
  end

  def can_visit(node)
    return true if !is_lower?(node)
    return true if !@stack.include?(node)
    return false if @stack.count(node) >= 2
    lower = @stack.filter{|n| is_lower?(n) && n != 'start'}
    return true if lower.size == lower.uniq.size
    return false
  end

  def visit()
    cur = @stack[-1]
    if cur == 'end'
      return 1
    end

    sum = 0
    @map[cur].each do |next_node|
      next if !can_visit(next_node)
      @stack << next_node
      sum += visit()
      @stack.pop
    end
    sum
  end

end

p Solver.new('12-input').calculate()
