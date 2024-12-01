str_lines = File.open('5.input').readlines

def has_3_vowels(str)
  str.count('aeiou') >= 3
end

def has_double_char(str)
  str.each_char.reduce  do |c1, c2|
    return true if c1 == c2

    c2
  end

  false
end

def no_prohibited(str)
  str.index('ab').nil? &&
    str.index('cd').nil? &&
    str.index('pq').nil? &&
    str.index('xy').nil?
end

count = 0
str_lines.each do |word|
  count += 1 if has_3_vowels(word) && has_double_char(word) && no_prohibited(word)
end
puts count

def has_xyx(str)
  for i in 0..(str.size - 3)
    return true if str[i] == str[i + 2]
  end
  false
end

def has_pair_twice(str)
  return false if str.size < 4
  return true unless str[2..].index(str[0..1]).nil?

  has_pair_twice(str[1..])
end

count = 0
str_lines.each do |word|
  count += 1 if has_xyx(word) && has_pair_twice(word)
end
puts count
