#!/usr/local/bin/ruby

# This program answers Advent of Code 2023 day 05
#
# Author::    Andre Onuki
# License::   GPL3
class Solver
  def solve(input)
    seeds = input[0].split(': ')[1].split(' ').map {|n| n.to_i}
    converters = Converter.map_builder(input[2..])

    location = nil
    seeds.each do |seed|
      item = ['seed', seed]

      while (item[0] != 'location')
        converter = converters[item[0]]
        item = converter.convert(item[1])
      end
      location = item[1] if location == nil || location > item[1]
    end
    location
  end

  def solve2(input)
    seeds = input[0].split(': ')[1].split(' ').map {|n| n.to_i}
    converters = Converter.map_builder(input[2..])
    min_location = nil
    ranges = []
    seeds.each_slice(2) do |start, size|
      ranges << [start, start + size - 1]
    end
    item = ['seed', ranges]
    while (item[0] != 'location')
      converter = converters[item[0]]
      item = converter.convert_range(item[1])
    end
    return item[1].sort[0][0]
  end
end

class Converter
  def initialize(data)
    @src_type, _, @dst_type = data[0].split(' ')[0].split('-')
    @ranges = data[1..].map {|line| RangeConverter.new(line)}
  end

  def source
    @src_type
  end

  def convert(num)
    @ranges.each do |range|
      converted = range.convert(num)
      return [@dst_type, converted] if converted != nil
    end
    return [@dst_type, num]
  end

  def convert_range(src_ranges)
    converted_ranges = []
    remaining = src_ranges

    @ranges.each do |converter|
      next_remaining = []
      remaining.each do |range|
        result = converter.convert_range(range)
        if result == nil
          next_remaining << range
        else
          converted_ranges << result[0]
          next_remaining.concat(result[1])
        end
      end
      remaining = next_remaining
    end
    return [@dst_type, converted_ranges.concat(remaining)]
  end

  def Converter.map_builder(data)
    maps = data.join.split("\n\n")
    converters = {}
    maps.each do |converter_data|
       converter = Converter.new(converter_data.split("\n"))
       converters[converter.source] = converter
    end
    converters
  end
end

class RangeConverter
  def initialize(line)
    @dst, @start, size = line.split(' ').map{|n| n.to_i}
    @end = @start + size - 1
  end

  def convert(n)
    if @start <= n && n <= @end
      return @dst + n - @start
    end
    nil
  end

  def convert_range(range)
    return nil if range[1] < @start
    return nil if @end < range[0]
    next_range = []
    remaining = []
    if range[0] <= @start
      next_range[0] = @dst
      remaining << [range[0], @start - 1] if range[0] < @start
    else
      next_range[0] = @dst + range[0] - @start
    end

    if @end <= range[1]
      next_range[1] = @dst + @end - @start
      remaining << [@end + 1, range[1]] if @end < range[1]
    else
      next_range[1] = @dst + range[1] - @start
    end

    [next_range, remaining]
  end
end
