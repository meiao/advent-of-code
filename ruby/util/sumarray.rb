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

  def to_a
    array = []
    populate_yield([], @sum, @size) { |i| array << i }
    array
  end

  private
  def populate_yield(array, sum, size, &block)
    if size == 1
      block.call(array.clone << sum)
    else
      array << 0
      (0..sum).each do |i|
        array[-1] = i
        populate_yield(array, sum - i, size - 1, &block)
      end
      array.pop
    end
  end

end
