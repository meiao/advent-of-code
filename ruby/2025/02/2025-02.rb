class Solver
  def solve(input)
    ranges = input.split(',')
    ranges.map{|r| invalid_ids(r).sum}.sum
  end

  def invalid_ids(range)
    str_range = range.split('-')
    return [] if unviable_range?(str_range)
    first = str_range[0].to_i
    last = str_range[1].to_i
    invalid_ids = []
    digits = str_range[0].length

    num = str_range[0][0..((digits/2)-1)]

    p [num, last, digits]
    loop do
      numnum = (num + num).to_i
      break if numnum > last
      invalid_ids << numnum if numnum >= first
      num = num.next
    end

    invalid_ids
  end

  def unviable_range?(str_range)
    str_range[0].length == str_range[1].length && str_range[0].length % 2 == 1
  end

  def solve2(input)
    ranges = input.split(',')
    ranges.map{|r| invalid_ids2(r).sum}.sum
  end

  def invalid_ids2(range)
    str_range = range.split('-')
    first = str_range[0].to_i
    last = str_range[1].to_i
    invalid_ids = []
    max_num = str_range[1][0, str_range[1].length / 2]
    max_num[-1] = '9'
    ('1'..max_num).each do |num|
      times = 2
      loop do
        numnum = (num * times).to_i
        break if numnum > last
        invalid_ids << numnum if numnum >= first
        times += 1
      end
    end

    invalid_ids.uniq
  end
end

input = []
while line = gets
  input << line
end
solver = Solver.new
puts solver.solve2(input[0])

