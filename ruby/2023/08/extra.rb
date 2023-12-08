
increment = 61*43*73* 59*47*53
base = 28141477150
#8245452805242
moduli = [17873,12599,21389,17287,13771,15529]
100000000.times do |i|
  right = true
  n = base + i * increment
  moduli.each do |m|
    if (n%m) != (m-1)
      right = false
      break
    end
  end
  if right
    p n
    break
  end
end

moduli.each do |m|
  p [8245452805242, m, 8245452805242 % m]
end
