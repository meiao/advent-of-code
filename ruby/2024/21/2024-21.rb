#!/usr/local/bin/ruby

# This program answers Advent of Code 2024 day 21
#
# Author::    Andre Onuki
# License::   GPL3
class Solver
  def solve(input, bot_count)
    @dir_map = directional_map()
    @cur_button = Array.new(bot_count, 'A')
    @bot_count = bot_count
    @cache = {}
    input.map { |seq| press_seq(seq) * seq.to_i }
         .sum
  end

  def press_seq(seq)
    dir_seq = seq_to_dir(seq)
    dir_to_dir(dir_seq, 0)
  end

  def seq_to_dir(seq)
    cur_digit = 'A'
    seq.split('').map do |digit|
      move = move_numeric(cur_digit, digit)
      cur_digit = digit
      move
    end.join
  end

  def move_numeric(from, to)
    move = ''
    from_row = numeric_row(from)
    to_row = numeric_row(to)
    from_col = numeric_col(from)
    to_col = numeric_col(to)

    return move_from_0a(from_row, from_col, to_row, to_col) if from_row == -1 && to_col == 0
    return move_to_0a(from_row, from_col, to_row, to_col) if to_row == -1 && from_col == 0

    move << '<' * (from_col - to_col) if from_col > to_col

    if from_row > to_row
      move << 'v' * (from_row - to_row)
    elsif from_row < to_row
      move << '^' * (to_row - from_row)
    end

    move << '>' * (to_col - from_col) if from_col < to_col
    move << 'A'
  end

  def move_from_0a(_from_row, from_col, to_row, to_col)
    move = ''
    move << '^' * (to_row + 1)
    if from_col > to_col
      move << '<' * (from_col - to_col)
    elsif from_col < to_col
      move << '>' * (to_col - from_col)
    end
    move << 'A'
  end

  def move_to_0a(from_row, from_col, _to_row, to_col)
    move = ''
    move << 'v' * (from_row + 1)
    move << '>' * (to_col - from_col)
    move << 'A'
  end

  def numeric_row(digit)
    if %w[0 A].include?(digit)
      -1
    else
      (digit.to_i - 1) / 3
    end
  end

  def numeric_col(digit)
    if digit == '0'
      1
    elsif digit == 'A'
      2
    else
      (digit.to_i - 1) % 3
    end
  end

  def dir_to_dir(seq, iteration)
    return seq.size if iteration == @bot_count

    cache_key = [seq, iteration, @cur_button[iteration]]
    cached = @cache[cache_key]
    unless cached.nil?
      @cur_button[iteration] = cached[1]
      return cached[0]
    end

    size = seq.split('').map do |button|
      move = @dir_map[[@cur_button[iteration], button]]
      @cur_button[iteration] = button
      dir_to_dir(move, iteration + 1)
    end.sum
    @cache[cache_key] = [size, @cur_button[iteration]]
    size
  end

  def directional_map
    map = {}
    map[%w[A A]] = 'A'
    map[['A', '^']] = '<A'
    map[['A', '<']] = 'v<<A'
    map[%w[A v]] = '<vA'
    map[['A', '>']] = 'vA'
    map[['^', 'A']] = '>A'
    map[['^', '^']] = 'A'
    map[['^', '<']] = 'v<A'
    map[['^', 'v']] = 'vA'
    map[['^', '>']] = 'v>A'
    map[['<', 'A']] = '>>^A'
    map[['<', '^']] = '>^A'
    map[['<', '<']] = 'A'
    map[['<', 'v']] = '>A'
    map[['<', '>']] = '>>A'
    map[%w[v A]] = '^>A'
    map[['v', '^']] = '^A'
    map[['v', '<']] = '<A'
    map[%w[v v]] = 'A'
    map[['v', '>']] = '>A'
    map[['>', 'A']] = '^A'
    map[['>', '^']] = '<^A'
    map[['>', '<']] = '<<A'
    map[['>', 'v']] = '<A'
    map[['>', '>']] = 'A'
    map
  end
end
