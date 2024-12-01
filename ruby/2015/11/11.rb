def sub(pass, letter)
  index = pass.index(letter)
  return pass if index.nil?

  (pass[0..(index - 1)] + letter.next).ljust(8, 'a')
end

def next_pass(prev)
  pass = sub(prev, 'i')
  pass = sub(pass, 'o')
  pass = sub(pass, 'l')
  return pass.next if pass == prev

  pass
end

def has_3_inc(pass)
  return false if pass.size < 3
  return true if pass[0].next == pass[1] && pass[1].next == pass[2]

  has_3_inc(pass[1..])
end

def has_oil(pass)
  pass.count('iol') > 0
end

def has_2_doubles(pass)
  i = 0
  doubles = 0
  while i < pass.size - 1
    if pass[i] == pass[i + 1]
      doubles += 1
      i += 2
    else
      i += 1
    end
    break if doubles > 1
  end
  doubles == 2
end

def valid(pass)
  return false if has_oil(pass)
  return false unless has_3_inc(pass)

  has_2_doubles(pass)
end
pass = 'vzbxxyzz'
while true
  pass = next_pass(pass)
  if valid(pass)
    puts pass
    break
  end
end
