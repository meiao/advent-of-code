class Processor
  def initialize
    @wires = {}
    @gates = {}
    @gates['AND'] = ->(arr) { arr[0] & arr[1] }
    @gates['OR'] = ->(arr) { arr[0] | arr[1] }
    @gates['LSHIFT'] = ->(arr) { (arr[0] << arr[1]) & 65_535 }
    @gates['RSHIFT'] = ->(arr) { arr[0] >> arr[1] }
  end

  def can_process?(line)
    wires_has_all_vars = line.split('->')[0].scan(/[a-z]+/)
                             .map { |var| !@wires[var].nil? }
                             .reduce { |v1, v2| v1 && v2 }
    wires_has_all_vars.nil? || wires_has_all_vars
  end

  def process(line)
    match = line.match(/->/)
    target = match.post_match
    @wires[target.strip] = calculate(match.pre_match)
  end

  def calculate(expr)
    if expr.include?('OR')
      calc_gate(expr, 'OR')
    elsif expr.include?('AND')
      calc_gate(expr, 'AND')
    elsif expr.include?('LSHIFT')
      calc_gate(expr, 'LSHIFT')
    elsif expr.include?('RSHIFT')
      calc_gate(expr, 'RSHIFT')
    elsif expr.include?('NOT')
      calc_not(expr)
    else
      calc_value(expr)
    end
  end

  def calc_gate(expr, op)
    params = expr.split(op)
                 .map { |param| calc_value(param) }
    @gates[op].call(params)
  end

  def calc_value(expr)
    expr.strip!
    return expr.to_i if expr =~ /[0-9]+/

    @wires[expr]
  end

  def calc_not(expr)
    param = expr.split('NOT')[1]
    value = calc_value(param)
    ~value & 65_535
  end

  def wire(l)
    @wires[l]
  end

  attr_reader :wires

  def reset_wires(value)
    @wires = {}
    @wires['b'] = value
  end
end

p = Processor.new

lines = File.open('7.input').readlines
until lines.empty?
  line = lines.pop
  if p.can_process?(line)
    p.process(line)
  else
    lines.insert(0, line)
  end
end

value = p.wire('a')
puts value

p.reset_wires(value)

lines = File.open('7.input2').readlines
until lines.empty?
  line = lines.pop

  if p.can_process?(line)
    p.process(line)
  else
    lines.insert(0, line)
  end
end

puts p.wire('a')
