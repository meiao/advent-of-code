str_lines = File.open('3.input').readlines

visited = {}

directions = {}
directions['^'] = [0, 1]
directions['<'] = [-1, 0]
directions['>'] = [1, 0]
directions['v'] = [0, -1]

santa_pos = [0, 0]

line = str_lines[0]

visited[santa_pos] = true
line.each_char do |char|
  santa_pos[0] += directions[char][0]
  santa_pos[1] += directions[char][1]
  visited[santa_pos] = true
end

puts visited.size

visited = {}
santa_pos = [0, 0]
bot_pos = [0, 0]
visited[santa_pos] = true
line.scan(/.{1,2}/).each do |pair|
  char = pair[0]
  santa_pos = [
    santa_pos[0] + directions[char][0],
    santa_pos[1] + directions[char][1]
  ]
  visited[santa_pos] = true

  next unless pair.size > 1

  char = pair[1]
  bot_pos = [
    bot_pos[0] + directions[char][0],
    bot_pos[1] + directions[char][1]
  ]
  visited[bot_pos] = true
end

puts visited.keys

puts visited.size
