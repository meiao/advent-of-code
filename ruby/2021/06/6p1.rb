lines = File.open('7-input-small').readlines.collect { |l| l.strip }

fish_by_group = [0, 0, 0, 0, 0, 0, 0]
fish_to_be_added = [0, 0, 0]

lines[0].split(',').each do |timer|
  fish_by_group[timer.to_i] += 1
end

0.upto(256).each do |i|
  fish_to_be_added << fish_by_group[i % 7]
  fish_by_group[(i - 1) % 7] += fish_to_be_added.shift
end

fish_to_be_added.pop
p fish_to_be_added.sum + fish_by_group.sum
