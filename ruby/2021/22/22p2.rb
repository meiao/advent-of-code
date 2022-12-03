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
    @removed = []
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
    mult - @removed.collect{|r| r.size}.sum
  end

  def remove(cube)
    inter = self.intersect(cube)
    return if inter.nil?

    @removed.each do |r|
      r.remove(inter)
    end
    @removed << inter
  end

end

data = IO.readlines('22-input').collect{|l| l.strip}
cubes = []

data.each do |line|
  c = Cube.from_string(line)
  cubes << c
end


processed = []
while !cubes.empty?
  cube = cubes.shift

  processed.each do |p|
    p.remove(cube)
  end

  if cube.action == 'on'
    processed << cube
  end
  puts "Cubes left: " + cubes.size.to_s
end

p processed.collect{|cube| cube.size}.sum
