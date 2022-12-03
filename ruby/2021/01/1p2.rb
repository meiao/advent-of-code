str_lines = File.open('1-input').readlines

values = str_lines.map {|l| l.to_i}

prev = 1000000000
window = [0]
increasing = 0
window << values.shift
window << values.shift
values.each do |x|
  window.shift
  window << x
  current = window.sum
  increasing += 1 if current > prev
  prev = current
end

puts increasing
