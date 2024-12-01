require_relative 'numberless_picross'
class Picross
  @@cache = {}

  def initialize(springs, numbers)
    @springs = springs
    @numbers = numbers
  end

  def self.create(springs, numbers)
    springs = '' if springs.nil?
    # p [springs, numbers]
    # p caller(1)
    return NumberlessPicross.new(springs) if numbers.empty?

    Picross.new(springs, numbers)
  end

  def calculate
    return @@cache[state] unless @@cache[state].nil?

    minimized = minimize
    return @@cache[minimized.state] unless @@cache[minimized.state].nil?

    value = minimized.do_calculate
    @@cache[state] = value
    @@cache[minimized.state] = value
    value
  end

  def ==(other)
    other.class == self.class && other.state == state
  end

  protected

  attr_accessor :springs, :numbers

  def minimize
    previous = self
    loop do
      modified = previous.operational_around_max
                         .join_operational
                         .clean_edges
      # .remove_broken
      # .remove_longest_from_start
      # .remove_leading_unknown
      # .remove_leading_unknown_small
      # .force_leading_broken
      # .reverse
      # .remove_broken
      # .remove_longest_from_start
      # .remove_leading_unknown
      # .remove_leading_unknown_small
      # .force_leading_broken
      # .reverse
      break if modified == previous

      previous = modified
    end
    previous
  end

  def join_operational
    return self if @springs.index('..').nil?

    Picross.create(@springs.gsub(/\.+/, '.'), @numbers)
  end

  def clean_edges
    return self if @springs[0] != '.' && @springs[-1] != '.'

    first = @springs[0] == '.' ? 1 : 0
    last = @springs[-1] == '.' ? -2 : -1
    Picross.create(@springs[first..last], @numbers)
  end

  def remove_broken
    return self if @springs.index('#' * @numbers[0]) != 0
    return Picross.create('#', []) if @springs[@numbers[0]] == '#'

    Picross.create(@springs[(@numbers[0] + 1)..-1], @numbers[1..-1])
  end

  def remove_longest_from_start
    max = @numbers.max
    return self if @numbers[0] != max || @numbers.count(max) > 1

    index = @springs.index('#' * max)
    return self if index.nil?
    return Picross.create('#', []) if @springs[index + max + 1] == '#'

    Picross.create(@springs[(index + max + 1)..-1], @numbers[1..-1])
  end

  def operational_around_max
    max = @numbers.max
    offset = 0
    springs = @springs.clone
    return Picross.create('#', []) if @springs.index('#' * (max + 1)) != nil

    while true
      index = @springs.index('#' * max, offset)
      break if index.nil?

      springs[index - 1] = '.' if index > 0
      springs[index + max] = '.'

      offset = index + max
    end
    return self if springs == @springs

    Picross.create(springs, @numbers)
  end

  def remove_leading_unknown
    return self if @springs[0] != '?'

    leading_unknowns = 1
    while @springs[leading_unknowns] == '?'
      leading_unknowns += 1
      return self if leading_unknowns > @numbers[0]
    end

    broken_next = 0
    broken_next += 1 while @springs[leading_unknowns + broken_next] == '#'

    return self if broken_next == 0
    return Picross.create('#', []) if broken_next > @numbers[0]

    removable_unknowns = leading_unknowns - (@numbers[0] - broken_next)
    return self if removable_unknowns <= 0

    Picross.create(@springs[removable_unknowns..-1], @numbers)
  end

  def remove_leading_unknown_small
    i = 0
    while true
      return self if @springs[i] == '#'
      break if @springs[i] == '.'
      break if @springs[i].nil?

      i += 1
    end

    return Picross.create(@springs[(i + 1)..-1], @numbers) if i < @numbers[0]

    self
  end

  def force_leading_broken
    found_broken = false
    new_springs = @springs.clone
    @numbers[0].times do |i|
      if found_broken
        new_springs[i] = '#' if new_springs[i] == '?'
      elsif new_springs[i] == '#'
        found_broken = true
      end
    end
    return Picross.create(new_springs, @numbers) if new_springs != @springs

    self
  end

  def reverse
    Picross.create(springs.reverse, numbers.reverse)
  end

  def do_calculate
    if @numbers.empty?
      return 0 if @springs.count('#') > 0

      return 1
    end
    return 0 if @numbers.sum > @springs.count('#') + @springs.count('?')
    return 0 if @numbers.sum < @springs.count('#')
    return 0 if @springs.include?('#' * (@numbers.max + 1))

    if @springs.count('?') <= 5
      calculate_simple
    elsif @springs.include? '.'
      calculate_split
    elsif @springs.include? '#?#'
      split_between_broken.map { |pic| pic.do_calculate }.sum
    else
      split_random_unknown.map { |pic| pic.do_calculate }.sum
    end
  end

  def calculate_split
    sum = 0
    split.each do |pair|
      value_1 = pair[0].calculate
      value_2 = value_1 == 0 ? 0 : pair[1].do_calculate
      sum += value_1 * value_2
    end
    sum
  end

  def split
    springs = @springs.split('.', 2)
    splits = []
    (@numbers.size + 1).times do |i|
      splits << [
        Picross.create(springs[0], @numbers[0, i]),
        Picross.create(springs[1], @numbers[i, @numbers.size])
      ]
    end
    splits
  end

  def split_between_broken
    return [self] unless @springs.include? '#?#'

    i = @springs.index('#?#')
    springs1 = @springs.clone
    springs1[i + 1] = '.'
    springs2 = @springs.clone
    springs2[i + 1] = '#'
    [Picross.create(springs1, @numbers), Picross.create(springs2, @numbers)]
  end

  def split_random_unknown
    return [self] unless @springs.include? '?'

    i = @springs.index('?', @springs.size / 3)
    i = @springs.index('?') if i.nil?
    springs1 = @springs.clone
    springs1[i] = '.'
    springs2 = @springs.clone
    springs2[i] = '#'
    [Picross.create(springs1, @numbers), Picross.create(springs2, @numbers)]
  end

  def calculate_simple
    expected_broken = @numbers.sum - @springs.count('#')
    unknown = @springs.count('?')
    base = 2**unknown
    sum = 0
    (2**unknown).times do |i|
      sub = (base + i).to_s(2).tr('01', '.#').split('')[1..-1]
      next if sub.count('#') != expected_broken

      sum += 1 if verify(sub)
    end
    sum
  end

  def verify(sub)
    str = ''
    @springs.each_char do |c|
      str << if c == '?'
               sub.shift
             else
               c
             end
    end
    calculated = str.gsub(/\.+/, '.').split('.').map { |broken| broken.size }
    calculated.shift if calculated[0] == 0
    calculated.pop if calculated[-1] == 0
    calculated == @numbers
  end

  def state
    [@springs, @numbers]
  end
end
