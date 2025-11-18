class Keypad
  def initialize
    @no = {
     "U" => [5, 2, 1, 4, 9],
     "R" => [1, 4, 9, 12, 13],
     "D" => [5, 10, 13, 12, 9],
     "L" => [1, 2, 5, 10, 13]
    }
    @transition = [nil,                            #0
      {"D" => 3},                                  #1
      {"R" => 3, "D" => 6},                        #2
      {"U" => 1, "R" => 4, "D" => 7, "L" => 2},    #3
      {"D" => 8, "L" => 3},                        #4
      {"R" => 6},                                  #5
      {"U" => 2, "R" => 7, "D" => 10, "L" => 5},   #6
      {"U" => 3, "R" => 8, "D" => 11, "L" => 6},   #7
      {"U" => 4, "R" => 9, "D" => 12, "L" => 7},   #8
      {"L" => 8},                                  #9
      {"U" => 6, "R" => 11},                       #10
      {"U" => 7, "R" => 12, "D" => 13, "L" => 10}, #11
      {"U" => 8, "L" => 11},                       #12
      {"U" => 11}                                  #13
    ]
  end

  def transition(num, dir)
    return num if @no[dir].include? num

    @transition[num][dir]
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
  def convert(num)
    return num.to_s if num <= 9
    letter = 'A'
    (num - 10).times{letter.next}
    letter
  end

  def solve(input)
    keypad = Keypad.new
    pos = 5
    code = ''
    input.split("\n").each do |line|
      pos = keypad.press(pos, line)
      code << convert(pos)
    end
    p code
  end
end

input = ''
while line = gets
  input << line
end

Solver.new.solve(input)
