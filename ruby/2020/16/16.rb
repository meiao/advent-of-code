class Processor
  def initialize
    ranges = File.readlines('16.input.ranges')

    @valid_ranges = []

    ranges.each do |range|
      values = range.split(': ')[1].split(' or ')
      values.each do |r|
        min, max = r.split('-')
        @valid_ranges << [min.to_i, max.to_i]
      end
    end
  end

  def valid?(number)
    @valid_ranges.each do |range|
      return true if number.between?(range[0], range[1])
    end
    false
  end

  def part1
    errors = 0
    tickets = File.readlines('16.input.nearby')
    tickets.each do |ticket|
      has_invalid_field = false
      ticket.split(',').each do |n|
        number = n.to_i
        unless valid?(number)
          errors += number
          has_invalid_field = true
        end
      end
      puts ticket unless has_invalid_field
    end
    errors
  end
end

puts Processor.new.part1
