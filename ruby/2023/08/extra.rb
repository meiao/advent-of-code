increment = 61 * 43 * 73 * 59 * 47 * 53
base = 28_141_477_150
# 8245452805242
moduli = [17_873, 12_599, 21_389, 17_287, 13_771, 15_529]
100_000_000.times do |i|
  right = true
  n = base + i * increment
  moduli.each do |m|
    if (n % m) != (m - 1)
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
  p [8_245_452_805_242, m, 8_245_452_805_242 % m]
end
