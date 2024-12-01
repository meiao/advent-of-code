lines = File.open('3-input').readlines.collect { |l| l.strip }

gamma_rate = ''

length = lines[0].length
length.times do |x|
  sum = 0
  lines.length.times do |y|
    sum += lines[y][x].to_i
  end

  gamma_rate << if sum > lines.length / 2
                  '1'
                else
                  '0'
                end
end

gamma_rate = gamma_rate.to_i(2)
epsilon_rate = gamma_rate ^ (2**length - 1)
puts epsilon_rate * gamma_rate
