lines = File.open('10.input.sorted').readlines

numbers = lines.map{|n| n.to_i}

prev = 0
threes = 0
ones = 0
numbers.each do |number|
  diff = number - prev
  threes += 1 if diff == 3
  ones += 1 if diff == 1
  prev = number
end

threes += 1
puts threes * ones

def count_perm(l, r)
  return 0 if l[-1] < r[0] - 3
  return 1 if r.size == 1
  l2 = Array.new(l)
  l2 << r[0]
  r2 = Array.new(r)
  r2.shift
  return count_perm(l, r2) + count_perm(l2, r2)
end

groups = []
cur_grp = [0]
groups << cur_grp
numbers.each do |number|
  if number == cur_grp[-1] + 3
    cur_grp = [number]
    groups << cur_grp
  else
    cur_grp << number
  end
end

mult = 1
groups.each do |grp|
  next if grp.size < 2
  mult *= count_perm([grp.shift], grp)
end
puts mult
