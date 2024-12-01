lines = File.open('8-input').readlines.collect { |l| l.strip }

class Panel
  def initialize(line)
    @patterns, @nums = line.split('|').collect { |v| v.strip.split(' ').collect { |p| p.split('').sort } }
    @map = {}
    @dict = {}
  end

  def get_size(size)
    @patterns.filter { |p| p.size == size }
  end

  def calculate
    @map[1] = get_size(2)[0]
    @map[4] = get_size(4)[0]
    @map[7] = get_size(3)[0]
    @map[8] = get_size(7)[0]
    @map[6] = get_size(6).filter { |p| (@map[1] - p).size == 1 }[0]

    @dict['c'] = (@map[1] - @map[6])[0]
    @dict['f'] = (@map[1] - [@dict['c']])[0]

    @map[5] = get_size(5).filter { |p| !p.include?(@dict['c']) }[0]
    @map[2] = get_size(5).filter { |p| !p.include?(@dict['f']) }[0]
    @map[3] = (get_size(5) - [@map[2], @map[5]])[0]

    @dict['e'] = (@map[6] - @map[5])[0]

    six_sided_no_six = get_size(6) - [@map[6]]
    @map[9] = six_sided_no_six.filter { |p| !p.include?(@dict['e']) }[0]
    @map[0] = (six_sided_no_six - [@map[9]])[0]

    reverse_map = @map.invert

    sum = 0
    @nums.each do |n|
      sum *= 10
      sum += reverse_map[n]
    end

    sum
  end
end

# p lines.map {|l| process_line(l)}.sum

p lines.map { |l| Panel.new(l).calculate }.sum
