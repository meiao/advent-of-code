str_lines = File.open('1-input').readlines

values = str_lines.map { |l| l.to_i }

prev = 1_000_000_000
increasing = 0
values.each do |x|
  increasing += 1 if x > prev
  prev = x
end

puts increasing
