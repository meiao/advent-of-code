lines = File.readlines('5.input.binary.sorted')

last_num = 58
lines.each do |line|
  cur = line.to_i(2)
  if cur != last_num + 1
    puts cur
    return
  end
  last_num = cur
end
