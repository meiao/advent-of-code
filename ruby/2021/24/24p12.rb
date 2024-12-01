class Program
  def initialize(lines)
    @operations = []

    lines.each do |line|
      tokens = line.split(' ')
      case tokens[0]
      when 'inp'
        @operations << ->(state, input) { state[tokens[1]] = { input.shift => true } }
      else
        if /[0-9]+/ =~ tokens[2]
          p 'nothing to do here'
        else
          @operations << ->(state, _input) { state[tokens[1]].merge!(state[tokens[2]]) }
        end
      end
    end
  end

  def run(input)
    state = { 'w' => {}, 'x' => {}, 'y' => {}, 'z' => {} }
    input = input.to_s.split('')

    ops = 0
    @operations.each do |op|
      ops += 1
      p ops
      p state
      p input
      op.call(state, input)
    end

    state['z']
  end
end

data = IO.readlines('24-input').collect { |l| l.strip }
p = Program.new(data)
p p.run('abcdefghijklm')
