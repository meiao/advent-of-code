class Processor
  def initialize
    @mem = {}
    @or_mask = 0
    @and_mask = 0
    @lines = File.open('14.input').readlines
  end

  def part1
    @lines.each do |line|
      op, value = line.split(' = ')
      if op == 'mask'
        define_mask(value)
      else
        set_mem(op, value)
      end
    end
    puts @mem.values.sum
  end

  def define_mask(mask)
    @or_mask = mask.tr('X', '0').to_i(2)
    @and_mask = mask.tr('X', '1').to_i(2)
  end

  def set_mem(op, value)
    position = op.split('[')[1].to_i
    @mem[position] = (value.to_i & @and_mask) | @or_mask
  end
end

Processor.new.part1
