#input = '389125467'
input = '538914762'
moves = 10000000

require './node'
cups = input.split('').map{|num| num.to_i}
map = []

head = Node.new(cups.shift)
tail = head
map[head.value] = head

cups.each do |cup|
  node = Node.new(cup)
  map[cup] = node
  tail.next= node
  tail = node
end

(10..1000000).each do |cup|
  node = Node.new(cup)
  map[cup] = node
  tail.next= node
  tail = node  
end

moves.times do |i|

  cur = head
  head = head.next
  cur.next= nil

  moving = head
  cut_off = moving.next.next
  head = cut_off.next
  cut_off.next= nil

  moving_vals = [moving.value, moving.next.value, moving.next.next.value]
  search = cur.value - 1
  search = map.size() - 1 if search == 0

  while moving_vals.include?(search)
    search -= 1
    search = map.size() - 1 if search == 0
  end

  map[search].insert(moving)

  while tail.next != nil
    tail = tail.next
  end

  tail.next= cur
  tail = cur
end

one = map[1]
puts one.next.value * one.next.next.value
