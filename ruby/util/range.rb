class Ranges
  def initialize
    @ranges = []
  end

  def add(a_range)
    intersections = @ranges.select { |range| intersect?(a_range, range) }
    if intersections.empty?
      @ranges << a_range
    else
      @ranges = @ranges.difference(intersections)
      @ranges << merge(a_range, intersections)
    end
  end

  def in?(value)
    @ranges.any? { |range| value.between?(range[0], range[1]) }
  end

  def to_a
    @ranges.map(&:clone)
  end

  private

  def merge(a_range, ranges)
    ranges.reduce(a_range) do |max_range, range|
      [
        [max_range[0], range[0]].min,
        [max_range[1], range[1]].max
      ]
    end
  end

  def intersect?(r1, r2)
    r1[0] <= r2[1] && r1[1] >= r2[0]
  end
end
