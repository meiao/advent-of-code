# iterates thru all arrays of the given size
# that have integer elements summing to the given sum
class SumArray
  def initialize(sum, size)
    @sum = sum
    @size = size
  end

  def each(&block)
    populate_yield([], @sum, @size, &block)
  end

  def populate_yield(array, sum, size, &block)
    if size == 1
      array << sum
      block.call(array)
    else
      (0..sum).each do |i|
        new_array = array.clone
        new_array << i
        populate_yield(new_array, sum - i, size - 1, &block)
      end
    end
  end

  def to_a
    array = []
    populate_yield([], @sum, @size) { |i| array << i }
    array
  end
end
