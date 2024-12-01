class Parser
  def initialize(data)
    @buffer = data
  end

  def bits_to_num(bits)
    @buffer.shift(bits).join.to_i(2)
  end

  def parse_package
    bits_to_num(3)

    package_type_id = bits_to_num(3)
    if package_type_id == 4
      parse_literal
    else
      parse_operator(package_type_id)
    end
  end

  def parse_literal
    number = []
    while true
      first_bit = bits_to_num(1)
      number.concat(@buffer.shift(4))
      break if first_bit == 0
    end
    number = number.join.to_i(2)
    p 'literal: ' + number.to_s
    number
  end

  def parse_operator(package_type_id)
    length_type_id = bits_to_num(1)
    packages = if length_type_id == 0
                 parse_operator_0
               else
                 parse_operator_1
               end
    return packages.sum if package_type_id == 0
    return packages.inject(:*) if package_type_id == 1
    return packages.min if package_type_id == 2
    return packages.max if package_type_id == 3

    if package_type_id == 5
      return 1 if packages[0] > packages[1]

      return 0
    end
    if package_type_id == 6
      return 1 if packages[0] < packages[1]

      return 0
    end
    return unless package_type_id == 7
    return 1 if packages[0] == packages[1]

    0
  end

  def parse_operator_0
    bits = bits_to_num(15)
    p 'operator 0 with ' + bits.to_s + ' bits'
    data = @buffer.shift(bits)
    parser = Parser.new(data)
    parser.parse_packages
  end

  def parse_operator_1
    count = bits_to_num(11)
    p 'operator 1 with ' + count.to_s + ' subpackages'
    packages = []
    count.times { packages << parse_package }
    packages
  end

  def parse_packages
    packages = []
    packages << parse_package while @buffer.join.to_i(2) > 0
    packages
  end

  attr_reader :version_sum
end

data = IO.readlines('16-input')[0].to_i(16).to_s(2).split('')
data.shift(4)
parser = Parser.new(data)
p parser.parse_package
