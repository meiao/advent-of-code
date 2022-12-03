class Processor
  @@lines = File.open('8.input').readlines

  def initialize(stack, acc, visited)
    @stack = stack
    @acc = acc
    @visited = Array.new(visited)
  end


  def part1
    while true
      @visited << @stack
      line = @@lines[@stack]
      op, value = line.split(' ')

      if op == 'nop'
        @stack += 1
      elsif op == 'acc'
        @stack += 1
        @acc += value.to_i
      elsif op == 'jmp'
        @stack += value.to_i
      end

      if @visited.include? @stack
        puts @acc
        break
      end

    end
  end

  def part2
    while true
      @visited << @stack
      line = @@lines[@stack]
      op, value = line.split(' ')
      vi = value.to_i
      if op == 'nop'
        Processor.new(@stack + vi, @acc, @visited).part2_sans_hack
        @stack += 1
      elsif op == 'acc'
        @stack += 1
        @acc += vi
      elsif op == 'jmp'
        Processor.new(@stack + 1, @acc, @visited).part2_sans_hack
        @stack += vi
      end

      if @visited.include? @stack
        puts @acc
        break
      end

    end
  end

  def part2_sans_hack
    while true
      @visited << @stack

      line = @@lines[@stack]

      op, value = line.split(' ')

      if op == 'nop'
        @stack += 1
      elsif op == 'acc'
        @stack += 1
        @acc += value.to_i
      elsif op == 'jmp'
        @stack += value.to_i
      end

      if @stack == @@lines.size
        puts @acc
        puts 'success'
        exit
      end

      if @visited.include? @stack
        return
      end

    end
  end

end


Processor.new(0,0,[]).part2
