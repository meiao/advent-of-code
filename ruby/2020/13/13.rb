lines = File.open('13.input').readlines

init = lines[0].to_i

buses = lines[1].split(',').filter { |bus| bus != 'x' }.map { |bus| bus.to_i }

min = nil
min_bus = nil
buses.each do |bus|
  mod = init % bus
  wait_time = bus - mod
  if min.nil? || min > wait_time
    min = wait_time
    min_bus = bus
  end
end
puts min * min_bus

## part 2

bus_sched = {}
buses = lines[1].split(',')
buses.each_index do |t|
  bus = buses[t]
  next if bus == 'x'

  bus_id = bus.to_i
  bus_sched[bus_id] = (bus_id - t) % bus_id
end

time = 0
step = 1
bus_sched.keys.sort.reverse.each do |bus_id|
  time += step while time % bus_id != bus_sched[bus_id]
  step *= bus_id
end
puts time
