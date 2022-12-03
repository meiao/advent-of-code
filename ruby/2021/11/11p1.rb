class Solver

  def initialize(lines)
    @data = lines
    @dir = [[-1, -1], [-1, 0], [-1, 1], [0, -1], [0, 1], [1, -1], [1, 0], [1, 1]]
  end

  def valid_neighbors(p)
    @dir.collect{|d| [d[0] + p[0], d[1] + p[1]]}.filter{|d| d[0] >= 0 && d[1] >= 0 && d[0] < 10 && d[1] < 10}
  end

  def simulate
    blowing = []
    10.times do |x|
      10.times do |y|
        @data[x][y] += 1
        blowing << [x,y] if @data[x][y] == 10
      end
    end

    blown = []
    while !blowing.empty?
      p = blowing.pop
      neighbors = valid_neighbors(p)
      neighbors.each do |n|
        @data[n[0]][n[1]] += 1
        blowing << n if @data[n[0]][n[1]] == 10
      end
      blown << p
    end

    blown.each do |p|
      @data[p[0]][p[1]] = 0
    end
    blown.size
  end

  def print
    puts
    @data.each do |l|
      p l
    end
  end

  def simulate_n(n)
    reached_n = false
    all_blown = false
    sum = 0
    10000.times do |i|
      blown = simulate()
      sum += blown if !reached_n
      if i == n - 1
        reached_n = true
        p 'score at n = ' + sum.to_s
      end

      if blown == 100
        all_blown = true
        p 'all blown on step ' + (i + 1).to_s
      end

      break if all_blown && reached_n
    end
  end


end

lines = File.open('11-input').readlines.collect {|l| l.strip.split('').collect{|i| i.to_i} }

Solver.new(lines).simulate_n(100)
