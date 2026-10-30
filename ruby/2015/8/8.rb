lines = File.readlines('8.input')

lines.each do |line|
  puts line.strip.dump
end

# finding out part 1
# cat  8.input | sed -E "s/\\\\(\"|\\\\|(x[0-9a-f]{2}))/}/g" | sed s/\"//g > 8.input.filtered
