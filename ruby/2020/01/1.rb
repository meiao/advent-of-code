str_lines = File.open('1-input.sorted').readlines

values = str_lines.map { |l| l.to_i }

def get2(values)
  values.each do |v1|
    values.each do |v2|
      next if v1 == v2 || v2 < v1

      sum = v1 + v2
      if sum == 2020
        puts v1 * v2
        return
      end

      break if sum > 2020
    end
  end
end

def get3(values)
  values.each do |v1|
    values.each do |v2|
      next if v1 >= v2

      values.each do |v3|
        next if v2 >= v3

        sum = v1 + v2 + v3
        if sum == 2020
          puts v1 * v2 * v3
          return
        end
        break if sum > 2020
      end
    end
  end
end

puts '2'
get2(values)

puts '3'
get3(values)
