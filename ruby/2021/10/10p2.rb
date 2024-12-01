class Solver
  def initialize
    @opening = ['(', '[', '{', '<']
    @closing = {}
    @closing['('] = ')'
    @closing['['] = ']'
    @closing['{'] = '}'
    @closing['<'] = '>'
    @score = {}
    @score['('] = 1
    @score['['] = 2
    @score['{'] = 3
    @score['<'] = 4
  end

  def calculate(line)
    stack = []
    line.length.times do |i|
      c = line[i]
      if @opening.include? c
        stack << c
      else
        open = stack.pop
        return 0 if @closing[open] != c
      end
    end

    sum = 0
    stack.reverse.each do |c|
      sum *= 5
      sum += @score[c]
    end

    sum
  end
end

lines = File.open('10-input').readlines.collect { |l| l.strip }

solver = Solver.new
results = lines.map { |l| solver.calculate(l) }.filter { |r| r > 0 }.sort
p results[results.size / 2]
