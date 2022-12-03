class Enhancer
  @@dir = [
    [-1, -1], [0, -1], [1, -1],
    [-1, 0],  [0, 0],  [1, 0],
    [-1, 1],  [0, 1], [1, 1]
  ]
  def initialize(algo, input)
    @algo = algo.each_char.collect{|c|
      if c == '#'
        true
      else
        false
      end
    }

    @image = new_image(false)
    input.size.times do |row|
      input[row].length.times do |col|
        if input[row][col] == '#'
          @image[[col, row]] = true
        end
      end
    end
  end

  def new_image(next_default)
    img = {}
    img.default = next_default
    img
  end

  def enhance()
    next_default = calc_next_default()
    next_image = new_image(next_default)

    non_default = []
    @image.keys.each do |p|
      @@dir.each do |d|
        non_default << sum(p, d)
      end
    end

    non_default.each do |p|
      v = []
      @@dir.each do |d|
        v << @image[sum(p, d)]
      end
      num = b_array_to_int(v)
      next_val = @algo[num]
      next_image[p] = next_val if next_val != next_default
    end

    @image = next_image
  end

  def sum(p1, p2)
    [p1[0] + p2[0], p1[1] + p2[1]]
  end

  def default()
    @image.default
  end

  def b_array_to_int(arr)
    arr.map{|b|
      if b
        '1'
      else
        '0'
      end
    }.join.to_i(2)
  end

  def calc_next_default()
    if default()
      return @algo[-1]
    else
      return @algo[0]
    end
  end

  def lit_up
    raise 'Default is true' if default()
    @image.size
  end

end


data = IO.readlines('20-input').collect{|l| l.strip}

algo = data.shift
data.shift # remove empty line
enhancer = Enhancer.new(algo, data)
50.times do
  enhancer.enhance()
end
p enhancer.lit_up()
