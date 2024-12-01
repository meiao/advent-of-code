class Program
  def initialize(lines)
    @operations = []

    lines.each do |line|
      tokens = line.split(' ')
      case tokens[0]
      when 'inp'
        @operations << ->(state, input) { state[tokens[1]] = input.shift }
      when 'add'
        @operations << if /[0-9]+/ =~ tokens[2]
                         ->(state, _input) { state[tokens[1]] += tokens[2].to_i }
                       else
                         ->(state, _input) { state[tokens[1]] += state[tokens[2]] }
                       end
      when 'mul'
        @operations << if /[0-9]+/ =~ tokens[2]
                         ->(state, _input) { state[tokens[1]] *= tokens[2].to_i }
                       else
                         ->(state, _input) { state[tokens[1]] *= state[tokens[2]] }
                       end
      when 'div'
        @operations << if /[0-9]+/ =~ tokens[2]
                         ->(state, _input) { state[tokens[1]] /= tokens[2].to_i }
                       else
                         ->(state, _input) { state[tokens[1]] /= state[tokens[2]] }
                       end
      when 'mod'
        @operations << if /[0-9]+/ =~ tokens[2]
                         ->(state, _input) { state[tokens[1]] %= tokens[2].to_i }
                       else
                         ->(state, _input) { state[tokens[1]] %= state[tokens[2]] }
                       end

      when 'eql'
        @operations << if /[0-9]+/ =~ tokens[2]
                         ->(state, _input) { state[tokens[1]] = state[tokens[1]] == tokens[2].to_i ? 1 : 0 }
                       else
                         ->(state, _input) { state[tokens[1]] = state[tokens[1]] == state[tokens[2]] ? 1 : 0 }
                       end
      end
    end
  end

  def run(input)
    state = { 'w' => 0, 'x' => 0, 'y' => 0, 'z' => 0 }
    input = input.to_s.split('').collect { |c| c.to_i }

    @operations.each do |op|
      op.call(state, input)
    end

    state['z'] == 0
  end
end

data = IO.readlines('24-input').collect { |l| l.strip }
p = Program.new(data)

max = 99_999_991_119_212
while true
  if /0/ =~ max.to_s
    max -= 1
    next
  end
  break if p.run(max)

  p max if max % 10_001 == 0
  max -= 1
end
p max
