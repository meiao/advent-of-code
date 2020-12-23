class Processor

  def initialize

    lines = File.open('13.input.parsed').readlines

    @matrix = {}
    lines.each do |line|
      p1, v, p2 = line.split(' ')
      @matrix[p1] = {} if @matrix[p1] == nil
      @matrix[p1][p2] = v.to_i
    end
  end

  def happy(people)
    size = people.size
    happyness = 0
    (0..(size-1)).each do |index|
      p = people[index]
      l = people[(index - 1) % size]
      r = people[(index + 1) % size]
      happyness += @matrix[p][l]
      happyness += @matrix[p][r]
    end
    return happyness
  end

  def calc_max(people)
    max = -10000000000000000000000000
    people.permutation do |perm|
      v = happy(perm)
      max = v if max < v
    end

    puts max
  end

  def part1
    people = @matrix.keys
    calc_max(people)
  end

  def part2
    @matrix['me'] = {}
    @matrix.keys.each do |p|
      @matrix[p]['me'] = 0
      @matrix['me'][p] = 0
    end
    people = @matrix.keys
    calc_max(people)
  end

end

Processor.new.part2
