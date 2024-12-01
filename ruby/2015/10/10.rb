def look_and_say(str)
  value = ''
  arr = str.split('')
  until arr.empty?
    cur_element = arr.shift
    repetition = 1
    while !arr.empty? && arr.first == cur_element
      arr.shift
      repetition += 1
    end
    value += repetition.to_s + cur_element
  end
  value
end

str = '1113222113'
50.times do |_each|
  str = look_and_say(str)
  puts str.size
end
