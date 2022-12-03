lines = File.open('8-input').readlines.collect {|l| l.strip }


p lines.collect {|l| l.split('|')[1].strip.split(' ')}.flatten.filter{|n| [2, 3, 4, 7].include? n.length}.count
