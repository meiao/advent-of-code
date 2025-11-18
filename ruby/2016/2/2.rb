class Keypad

  def transition(num, dir)
    if dir == 'U'
      return num if num <= 3
      return num - 3
    end
    if dir == 'R'
      return num if num % 3 == 0
      return num + 1
    end
    if dir == 'D'
      return num if num >= 7
      return num + 3
    end
    if dir == 'L'
      return num if num % 3 == 1
      return num - 1
    end
    p num, dir
  end

  def press(startNum, instructions)
    num = startNum
    instructions.split('').each do |dir|
      num = transition(num, dir)
    end
    num
  end

end

class Solver
  def solve(input)
    keypad = Keypad.new
    pos = 5
    code = 0
    input.split("\n").each do |line|
      pos = keypad.press(pos, line)
      code = code * 10 + pos
    end
    p code
  end
end

input = ''
while line = gets
  input << line
end

Solver.new.solve(input)
