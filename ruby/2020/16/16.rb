class Processor
  def initialize
    ranges = File.open('16.input.ranges').readlines

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
      return true if range[0] <= number && number <= range[1]
    end
    return false
  end

  def part1
    errors = 0
    tickets = File.open('16.input.nearby').readlines
    tickets.each do |ticket|
      has_invalid_field = false
      ticket.split(',').each do |n|
        number = n.to_i
        if !valid?(number)
          errors += number
          has_invalid_field = true
        end
      end
      puts ticket.to_s if !has_invalid_field

    end
    errors
  end

end

puts Processor.new.part1
