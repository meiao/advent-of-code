class Processor
  def initialize
    @mem = {}
    @mask = ''
    @lines = File.open('14.input').readlines
  end

  def part2
    @lines.each do |line|
      op, value = line.split(' = ')
      if op == 'mask'
        @mask = value.strip
      else
        set_mem(op, value.to_i)
      end
    end
    puts @mem.values.sum
  end

  def set_mem(op, value)
    position = op.split('[')[1].to_i
    address = calc_address(position)
    (2**@mask.count('X')).times do |i|
      decoded_position = decode_position(address, i).to_i(2)
      @mem[decoded_position] = value
    end

  end

  def calc_address(position)
    address = position.to_s(2).rjust(36, '0')
    36.times do |i|
      if @mask[i] == '1'
        address[i] = '1'
      elsif @mask[i] == 'X'
        address[i] = 'X'
      end
    end
    address
  end

  def decode_position(address, number)
    values = number.to_s(2).rjust(address.count('X'), '0').split('')
    decoded_position = String.new(address)
    while decoded_position.count('X') > 0
      index = decoded_position.index('X')
      decoded_position[index] = values.shift
    end
    return decoded_position
  end


end



Processor.new.part2
