class NumberlessPicross

  def initialize(springs)
    @springs = springs
  end

  def state
    [@springs, []]
  end

  def calculate
    do_calculate
  end

  def minimize
    self
  end

  def join_operational
    self
  end

  def clean_edges
    self
  end

  def remove_broken
    self
  end

  def remove_longest_from_start
    self
  end

  def operational_around_max
    self
  end

  def remove_leading_unknown
    self
  end

  def remove_leading_unknown_small
    self
  end

  def force_leading_broken
    self
  end

  def reverse
    self
  end

  def do_calculate
    return 0 if @springs.count('#') > 0
    1
  end

end
