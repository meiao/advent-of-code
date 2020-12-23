def sub(pass, letter)
  index = pass.index(letter)
  if index == nil
    return pass
  else
    return (pass[0..(index-1)] + letter.next).ljust(8, 'a')
  end
end

def next_pass(prev)
  pass = sub(prev, 'i')
  pass = sub(pass, 'o')
  pass = sub(pass, 'l')
  if pass == prev
    return pass.next
  else
    return pass
  end
end

def has_3_inc(pass)
  return false if pass.size < 3
  return true if pass[0].next() == pass[1] && pass[1].next() == pass[2]
  return has_3_inc(pass[1..])
end

def has_oil(pass)
  return pass.count('iol') > 0
end

def has_2_doubles(pass)
  i = 0
  doubles = 0
  while i < pass.size - 1
    if pass[i] == pass[i+1]
      doubles += 1
      i += 2
    else
      i += 1
    end
    break if doubles > 1
  end
  return doubles == 2
end

def valid(pass)
  return false if has_oil(pass)
  return false if !has_3_inc(pass)
  return has_2_doubles(pass)
end

pass = 'vzbxkghb'
pass = 'vzbxxyzz'
while true
  pass = next_pass(pass)
  if valid(pass)
    puts pass
    break
  end
end
