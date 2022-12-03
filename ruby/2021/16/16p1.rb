class Parser
  def initialize(data)
    @buffer = data
    @version_sum = 0
  end

  def bits_to_num(bits)
    @buffer.shift(bits).join.to_i(2)
  end


  def parse_package()
    version = bits_to_num(3)
    @version_sum += version

    package_type_id = bits_to_num(3)
    if package_type_id == 4
      parse_literal()
    else
      parse_operator()
    end
  end

  def parse_literal()
    number = []
    while true do
      first_bit = bits_to_num(1)
      number.concat(@buffer.shift(4))
      break if first_bit == 0
    end
    p "literal: " + number.join.to_i(2).to_s
  end

  def parse_operator()
    length_type_id = bits_to_num(1)
    if length_type_id == 0
      parse_operator_0()
    else
      parse_operator_1()
    end
  end

  def parse_operator_0
    bits = bits_to_num(15)
    p "operator 0 with " + bits.to_s + " bits"
    data = @buffer.shift(bits)
    parser = Parser.new(data)
    parser.parse_packages()
    @version_sum += parser.version_sum
  end

  def parse_operator_1
    packages = bits_to_num(11)
    p "operator 1 with " + packages.to_s + " subpackages"
    packages.times { parse_package() }
  end

  def parse_packages()
    while @buffer.join.to_i(2) > 0
      parse_package()
    end
  end

  def version_sum
    @version_sum
  end
end

data = IO.readlines('16-input')[0].to_i(16).to_s(2).split('')
data.shift(4)
parser = Parser.new(data)
parser.parse_package()
p parser.version_sum
