lines = File.open('7-input').readlines.collect { |l| l.strip }

data = lines[0].split(',').collect { |x| x.to_i }.sort
position = data[data.size / 2]
p data.collect { |x| (x - position).abs }.sum
