class Solver
  def solve(input, battery_count)
    input.map{|line| line.strip.split('').map(&:to_i)}
         .map{|batteries| max_joltage(batteries, battery_count)}
         .sum
  end

  # Gets the max digit in a sub array for the most significant digit.
  # This sub array starts at 0, but ends at battery_count batteries from the end.
  # Doing so ensures that the most significant digit is the highest and there are
  # at least battery_count-1 batteries to turn on.
  # Then selects the next most significant digits recursively, using the sub array
  # starting after the selected digit to the end.
  def max_joltage(batteries, battery_count)
    return batteries.reduce(0){|sum, num| sum * 10 + num} if batteries.length == battery_count

    max = batteries[0..-battery_count].max
    return max if battery_count == 1

    max_index = batteries.index(max)
    power10 = 10**(battery_count - 1)
    max * power10 + max_joltage(batteries[max_index+1..], battery_count - 1)
  end
end
