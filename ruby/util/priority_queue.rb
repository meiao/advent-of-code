# Simple priority queue.
# backed by an array and a map.
# Array is sorted prior to minimal retrieving if there are any changes.
class PriorityQueue
  def initialize
    @arr = []
    @map = {}
    @changed = false
  end

  def push(item, priority)
    if @map.key? item
      if priority < @map[item][1]
        @map[item][1] = priority
        @changed = true
      end
    else
      pair = [item, priority]
      @map[item] = pair
      @arr << pair
      @changed = true
    end
  end

  def min
    if @changed
      @arr.sort! { |x, y| x[1] <=> y[1] }
      @changed = false
    end

    item, = @arr.shift
    @map.delete(item)
    item
  end

  def empty?
    @arr.empty?
  end
end
