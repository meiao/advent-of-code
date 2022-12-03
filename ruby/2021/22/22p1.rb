class Cube

  def self.from_string(str)
    action, data = str.split(' ')
    arr = data.split(',').collect{|d| d[2..].split('..').collect{|n| n.to_i}}
    l = []
    r = []
    arr.each do |pair|
      l << pair[0]
      r << pair[1]
    end
    Cube.new(l, r, action)
  end

  def initialize(l, r, action)
    @l = l
    @r = r
    @action = action
  end

  def contains?(p)
    3.times do |i|
      return false if @l[i] > p[i] || @r[i] < p[i]
    end
    true
  end

  def points
    ps = []
    (@l[0]..@r[0]).each do |x|
      (@l[1]..@r[1]).each do |y|
        (@l[2]..@r[2]).each do |z|
          ps << [x, y, z]
        end
      end
    end
    ps
  end

  def intersect(other)
    next_l = []
    next_r = []
    3.times do |i|
      return nil if @l[i] > other.r[i] || @r[i] < other.l[i]
      next_l << [@l[i], other.l[i]].max
      next_r << [@r[i], other.r[i]].min
    end
    return Cube.new(next_l, next_r, 'none')
  end

  def l
    @l
  end

  def r
    @r
  end

  def action
    @action
  end

  def size
    mult = 1
    3.times do |i|
      mult *= @r[i] - @l[i] + 1
    end
    mult
  end

  def ==(other)
    @l == other.l && @r == other.r
  end

  def valid?
    partially_out = false
    3.times do |i|
      if @l[i] > 50 || @r[i] < -50
        return false
      end
    end
    true
  end

end


data = IO.readlines('22-input').collect{|l| l.strip}
cubes = []

data.each do |line|
  c = Cube.from_string(line)
  if c.valid?
    cubes << c
  end
end


processed = []
#assuming last one is on
first = cubes.pop
lit = first.size
processed << first

while !cubes.empty?
  cube = cubes.pop
  if cube.action == 'on'
    intersect = []
    processed.each do |p_cube|
      intersect << p_cube.intersect(cube)
    end
    intersect.compact!
    if intersect.empty?
      lit += cube.size
      next
    end

    cube.points.each do |p|
      lit += 1 if intersect.none?{|c| c.contains?(p)}
    end
  end
  processed << cube
  puts "Cubes left: " + cubes.size.to_s
end

p lit
