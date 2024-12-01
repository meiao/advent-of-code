lines = File.open('18.input').readlines

def get_value(expr)
  value = expr.shift
  if value == '('
    eval(expr)
  else
    value.to_i
  end
end

def eval(expr)
  value = get_value(expr)

  while !expr.empty? && expr[0] != ')'
    op = expr.shift
    next_value = get_value(expr)

    case op
    when '+'
      value += next_value
    when '-'
      value -= next_value
    when '*'
      value *= next_value
    when '/'
      value /= next_value
    end
  end

  expr.shift if !expr.empty? && expr[0] == ')'
  value
end

sum = 0
lines.each do |line|
  expr = line.split(' ')
  sum += eval(expr)
end

puts sum
