# 2929 low
data = IO.readlines('17-input')[0]
pieces = data.split(' ')
x_range = pieces[2].split('=')[1][0..-2].split('..').collect { |n| n.to_i }
y_range = pieces[3].split('=')[1].split('..').collect { |n| n.to_i }

x_hit_by_step = Hash.new { |hash, key| hash[key] = [] }

1.upto(x_range[1]) do |n|
  traveled = 0
  step = 0
  while traveled <= x_range[1]
    traveled += n - step
    step += 1
    x_hit_by_step[step] << n if x_range[0] <= traveled && traveled <= x_range[1]
    break if step > 19
  end
end
x_hit_by_step.default = [16, 17]
x_hit_by_step.keys.sort.each do |k|
  print k.to_s + '=>'
  p x_hit_by_step[k]
end

y_hit_by_step = Hash.new { |hash, key| hash[key] = [] }
hits = {}
y_range[0].upto(150) do |y|
  position = 0
  step = 0
  while position > y_range[0]
    position += y - step
    step += 1
    next unless y_range[0] <= position && position <= y_range[1]

    y_hit_by_step[step] << y
    x_hit_by_step[step].each do |x|
      hits[[x, y]] = true
    end
  end
end

# p "y"
# y_hit_by_step.keys.sort.each do |k|
#   print k.to_s + '=>'
#   p y_hit_by_step[k]
# end

# hits.keys.each do |k|
#   puts k[0].to_s + ',' + k[1].to_s
# end
p hits.size
