data = IO.readlines('17-input')[0]
pieces = data.split(' ')
pieces[2].split('=')[1][0..-2].split('..').collect { |n| n.to_i }
y_range = pieces[3].split('=')[1].split('..').collect { |n| n.to_i }

binomials = []
1.upto(1000) do |i|
  binomials << i * (i + 1) / 2
end

max_height_hit = 0
1.upto(1000) do |y|
  max_height = y * (y + 1) / 2
  y_range[0].upto(y_range[1]) do |i|
    to_hit = max_height - i
    hit = binomials.include?(to_hit)
    max_height_hit = max_height if hit
  end
end

p max_height_hit
