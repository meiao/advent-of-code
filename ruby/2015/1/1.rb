str_lines = File.open('1.input').readlines

line = str_lines[0]

index = 0
pos = 0

while index < line.size
  if line[index] == '('
    pos += 1
  elsif pos -= 1
  end

  if pos == -1
    puts index + 1
    break
  end

  index += 1

end
