#!/usr/local/bin/ruby

# This program answers Advent of Code 2023 day 01
#
# Author::    Andre Onuki
# License::   GPL3
class Solver
  def solve(input)
    sum = 0
    regex_2_digits = /^[a-z]*([0-9]).*([0-9])[a-z]*$/
    regex_1_digit = /([0-9])/
    input.each do |line|
      line = line.strip
      match = line.match(regex_2_digits)
      if match == nil
        match = line.match(regex_1_digit)
        sum += (match[1] * 2).to_i
      else
        sum += (match[1] + match[2]).to_i
      end
    end
    sum
  end

  def solve2(input)
    map = {}
    map['one'] = 1
    map['two'] = 2
    map['three'] = 3
    map['four'] = 4
    map['five'] = 5
    map['six'] = 6
    map['seven'] = 7
    map['eight'] = 8
    map['nine'] = 9
    map['eno'] = 1
    map['owt'] = 2
    map['eerht'] = 3
    map['ruof'] = 4
    map['evif'] = 5
    map['xis'] = 6
    map['neves'] = 7
    map['thgie'] = 8
    map['enin'] = 9
    first_number_regex = /^[a-z]*?((one)|(two)|(three)|(four)|(five)|(six)|(seven)|(eight)|(nine)|(\d))/
    # my first try for a regex for the last number was ((one)|(two)|...(\d))[a-z]*?$
    # but *?$ works just like *, not the minimal number of chars like I expected.
    # so I reversed the string and for the beginning of the string, that works as expected
    last_number_regex = /^[a-z]*?((eno)|(owt)|(eerht)|(ruof)|(evif)|(xis)|(neves)|(thgie)|(enin)|(\d))/
    number_regex = /\d/
    sum = 0
    input.each do |line|
      match = line.match(first_number_regex)
      digits = []
      if match[1] =~ number_regex
        sum += match[1].to_i * 10
      else
        sum += map[match[1]] * 10
      end

      match = line.reverse.match(last_number_regex)
      if match[1] =~ number_regex
        sum += match[1].to_i
      else
        sum += map[match[1]]
      end
    end

    sum
  end
end
