# input = '389125467'
input = '538914762'
moves = 100
cups = input.split('').map { |num| num.to_i }

def move(cups)
  size = cups.size
  moving = cups.shift(4)

  search = moving[0] - 1
  search = size if search == 0

  while moving.include? search
    search -= 1
    search = size if search == 0
  end
  index = cups.index(search)

  cups.push(moving.shift)
  cups.insert(index + 1, moving)
  cups.flatten!

  cups
end

moves.times do
  move(cups)
end

cups.push(cups.shift) while cups[0] != 1

puts cups.join('')

require './node'
cups = input.split('').map { |num| num.to_i }
map = []

head = Node.new(cups.shift)
tail = head
map[head.value] = head

cups.each do |cup|
  node = Node.new(cup)
  map[cup] = node
  tail.next = node
  tail = node
end

moves.times do |_i|
  cur = head
  head = head.next
  cur.next = nil

  moving = head
  cut_off = moving.next.next
  head = cut_off.next
  cut_off.next = nil

  moving_vals = [moving.value, moving.next.value, moving.next.next.value]
  search = cur.value - 1
  search = map.size - 1 if search == 0

  while moving_vals.include?(search)
    search -= 1
    search = map.size - 1 if search == 0
  end

  map[search].insert(moving)

  tail = tail.next until tail.next.nil?

  tail.next = cur
  tail = cur
end

n = head
until n.nil?
  print n.value
  n = n.next
end
