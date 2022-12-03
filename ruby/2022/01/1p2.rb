lines = File.open('1-input').readlines

elves = []
current = 0
lines.each do |line|
  if line == "\n"
    elves << current
    current = 0
  else
    current += line.to_i
  end
end

p elves.sort.reverse[0..2].sum
