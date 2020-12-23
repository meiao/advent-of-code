require 'digest'

target1 = '00000'
target2 = '000000'

prefix = 'yzbqklnj'

num = 0

while true
  calculated = Digest::MD5.hexdigest(prefix + num.to_s)[0,5]
  if calculated == target1
    puts num
    break
  end
  num += 1
end

while true
  calculated = Digest::MD5.hexdigest(prefix + num.to_s)[0,6]
  if calculated == target2
    puts num
    break
  end
  num += 1
end
