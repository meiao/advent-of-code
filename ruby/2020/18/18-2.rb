lines = File.open('18.input').readlines

def has_precedence?(from_stack, token)
  return false if from_stack == nil
  return false if from_stack == '('
  return true if from_stack.count('+-') > 0
  return false if token.count('+-') > 0
  return true
end

def eval(expr)
  output = []
  operator = []

  exec = {}
  exec['/'] = ->(a,b) { a / b }
  exec['*'] = ->(a,b) { a * b }
  exec['+'] = ->(a,b) { a + b }
  exec['-'] = ->(a,b) { a - b }

  while !expr.empty?
    token = expr.shift
    if token.count('0123456789') > 0
      output << token.to_i
    elsif token.count('-+*/') > 0
      while has_precedence?(operator[-1], token)
        output << exec[operator.pop].call(output.pop, output.pop)
      end
      operator << token
    elsif token == '('
      operator << token
    elsif token == ')'
      while (op = operator.pop) != '('
        output << exec[op].call(output.pop, output.pop)
      end
    else
      puts 'error'
    end
  end
  while !operator.empty?
    output << exec[operator.pop].call(output.pop, output.pop)
  end
  return output[0]
end

sum = 0
lines.each do |line|
  expr = line.split(' ')
  val = eval(expr)
  puts val
  sum += val
end

puts sum
