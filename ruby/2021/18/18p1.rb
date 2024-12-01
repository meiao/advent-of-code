class Calculator
  def initialize(num)
    @value = Calculator.parse(num)
  end

  def self.parse(num)
    data = num.split('')

    value = []
    until data.empty?
      data.shift while data[0] == ','
      if data[0] == '[' || data[0] == ']'
        value << data.shift
      else
        v = 0
        while data[0] != ',' && data[0] != ']'
          v *= 10
          v += data.shift.to_i
        end
        value << v
      end
    end
    value
  end

  def add(num)
    old_value = @value
    @value = ['[']
    @value.concat(old_value)
    @value.concat(Calculator.parse(num))
    @value << ']'
    while true
      exploded = explode
      next if exploded

      splitted = split
      break unless splitted
    end
  end

  def explode
    exploded = false
    depth = 0
    old_value = @value
    @value = []
    until old_value.empty?
      if old_value[0] == '['
        old_value.shift # remove [
        if depth < 4
          @value << '['
          depth += 1
        else
          exploded = true
          i = num_index(@value, -1, -1)
          v = old_value.shift
          @value[i] += v unless i.nil?

          v = old_value.shift
          old_value.shift # remove ]
          i = num_index(old_value, 0, 1)
          old_value[i] += v unless i.nil?

          @value << 0
          break
        end
      else
        depth -= 1 if old_value[0] == ']'
        @value << old_value.shift
      end
    end

    @value << old_value.shift until old_value.empty?

    exploded
  end

  def split
    old_value = @value
    @value = []
    splitted = false
    until old_value.empty?
      v = old_value.shift
      if v.is_a?(Numeric) && v >= 10
        @value.concat(get_split(v))
        splitted = true
        break
      else
        @value << v
      end
    end

    @value << old_value.shift until old_value.empty?
    splitted
  end

  def get_split(num)
    ['[', num / 2, (num + 1) / 2, ']']
  end

  def num_index(arr, ini, dir)
    i = ini
    until arr[i].nil?
      return i if arr[i].is_a? Numeric

      i += dir
    end
    nil
  end

  attr_reader :value

  def magnitude
    old_value = @value
    @value = []
    until old_value.empty?
      if @value[-1].is_a?(Numeric) && @value[-2].is_a?(Numeric)
        v = @value.pop * 2 + value.pop * 3
        @value.pop # removes '['
        old_value.shift # remove ']'
        @value << v
      else
        @value << old_value.shift
      end
    end
    @value[0]
  end
end

data = IO.readlines('18-input').collect { |l| l.strip }
calc = Calculator.new(data[0])
data[1..].each do |l|
  calc.add(l)
end
p calc.magnitude

max = 0
data.size.times do |i|
  data.size.times do |j|
    next if i == j

    calc = Calculator.new(data[i])
    calc.add(data[j])
    mag = calc.magnitude
    max = mag if mag > max
  end
end
p max
