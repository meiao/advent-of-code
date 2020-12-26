def calculate_loop(expected, sub_no, modulo)
  cur = 1
  loops = 0
  while cur != expected
    cur = (cur * sub_no) % modulo
    loops += 1
  end
  return loops
end

def loop(key, loops, sub_no, modulo)
  cur = key
  loops.times do
    cur = (cur * sub_no) % modulo
  end
  return cur
end

key1 = 3418282
key2 = 8719412
loops1 = calculate_loop(key1, 7, 20201227)
loops2 = calculate_loop(key2, 7, 20201227)

#puts loop(key2, loops1, 7, 20201227)
#puts loop(key1, loops2, 7, 20201227)
puts loop(1, loops2, key1, 20201227)
