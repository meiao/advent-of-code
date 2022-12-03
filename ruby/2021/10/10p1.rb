class Solver

  def initialize
    @opening = ['(', '[', '{', '<']
    @closing = {}
    @closing['('] = ')'
    @closing['['] = ']'
    @closing['{'] = '}'
    @closing['<'] = '>'
    @score = {}
    @score[')'] = 3
    @score[']'] = 57
    @score['}'] = 1197
    @score['>'] = 25137
  end

  def calculate(line)
    stack = []
    line.length.times do |i|
      c = line[i]
      if @opening.include? c
        stack << c
      else
        open = stack.pop
        return @score[c] if @closing[open] != c
      end
    end
    return 0
  end
end

lines = File.open('10-input').readlines.collect {|l| l.strip }

solver = Solver.new
p lines.map{|l| solver.calculate(l)}.sum
