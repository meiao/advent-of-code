def calc1(n, p)
  v = [n, p].sort
  (v[1] - v[0] + 1) * (v[1] - v[0]) / 2
end

def calcn(data, p)
  data.collect { |n| calc1(n, p) }.sum
end

lines = File.open('7-input').readlines.collect { |l| l.strip }
data = lines[0].split(',').collect { |x| x.to_i }.sort
p data[-1].times.collect { |p| calcn(data, p) }.min
