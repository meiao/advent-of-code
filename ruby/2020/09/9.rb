lines = File.open('9.input').readlines

numbers = []
25.times do
  numbers << lines.shift.to_i
end

lines.each do |line|
  v = line.to_i
  found = false
  numbers.each do |n|
    next unless numbers.include?(v - n)

    not_double = v != 2 * n
    has_dupe_n = numbers.count(n) > 1
    next unless not_double || has_dupe_n

    numbers.shift
    numbers << v
    found = true
    break
  end
  unless found
    puts v
    break
  end
end

nums = lines.map { |n| n.to_i }

l = 0
r = 1
expected = 21_806_024
while true
  sum = nums[l..r].sum
  if sum == expected
    break
  elsif sum < expected
    r += 1
  else
    l += 1
  end
end

sorted = nums[l..r].sort
puts sorted[0] + sorted[-1]
