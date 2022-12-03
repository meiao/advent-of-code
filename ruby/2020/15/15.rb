num_index = {}

i = 1

input = [7,12,1,0,16,2]


input.each do |n|
  num_index[n] = i
  i += 1
end

num_index[input[-1]] = nil
i -= 1

last_num = input[-1]
while i < 30000000
  if num_index[last_num] == nil
    next_num = 0
  else
    next_num = i - num_index[last_num]
  end
  num_index[last_num] = i
  i += 1
  last_num = next_num
end
puts last_num
