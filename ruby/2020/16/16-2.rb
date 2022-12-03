class Processor
  def initialize
    lines = File.open('16.input.ranges').readlines

    @range_map = {}

    lines.each do |line|
      range_name, ranges = line.split(': ')
      @range_map[range_name] = []
      ranges.split(' or ').each do |range|
        min, max = range.split('-')
        @range_map[range_name] << [min.to_i, max.to_i]
      end
    end

    @possible_columns = {}
    @range_map.keys.each do |range_name|
      @possible_columns[range_name] = (0..(@range_map.size-1)).to_a
    end
  end

  def in_range?(number, range)
    return range[0] <= number && number <= range[1]
  end

  def check_valid(number, column)
    @range_map.keys.each do |key|
      ranges = @range_map[key]
      in_range = in_range?(number, ranges[0]) || in_range?(number, ranges[1])
      @possible_columns[key].delete(column) if !in_range
    end
  end

  def clear_invalid_columns
    lines = File.open('16.input.tickets.valid').readlines
    lines.each do |line|
      ticket = line.split(',').map{|n| n.to_i}
      ticket.each_index do |column|
        number = ticket[column]
        check_valid(number, column)
      end
    end
  end

  def filter_columns
    @verified_columns = {}
    while !@possible_columns.empty?
      @possible_columns.keys.each do |range_name|
        next if @possible_columns[range_name].size > 1
        column = @possible_columns[range_name][0]
        @verified_columns[range_name] = column
        @possible_columns.values.each do |columns|
          columns.delete(column)
        end
        @possible_columns.delete(range_name)
      end
    end
  end

  def result
    ticket = File.open('16.input.ticket').readlines[0].split(',')
    value = 1
    keys = [
      'departure time',
      'departure station',
      'departure platform',
      'departure date',
      'departure location',
      'departure track'
    ]
    keys.each do |key|
      value *= ticket[@verified_columns[key]].to_i
    end
    return value
  end

end

p = Processor.new
p.clear_invalid_columns
p.filter_columns
puts p.result
