class Solver

  def solve(input)
    input.map{|line|clicks_to_turn_on(line)}
         .sum
  end

  def clicks_to_turn_on(line)
    final_state, buttons, joltage = decode_machine(line)
    seen_states = Hash.new(false)
    initial_state = Array.new(final_state.size, false)
    return 0 if final_state == initial_state
    seen_states[initial_state] = true
    clicks = 0
    loop do
      clicks += 1
      seen_states.keys.each do |state|
        buttons.each do |button|
          new_state = press(state, button)
          return clicks if final_state == new_state
          seen_states[new_state] = true
        end
      end
    end
  end

  def decode_machine(line)
    parts = line.split(' ')

    final_state = parts[0][1..-2].chars.map{|c| c == '#'}

    buttons = parts[1..-2].map{|buttons| buttons[1..-2].split(',').map(&:to_i)}

    joltage = parts[-1][1..-2].split(',').map(&:to_i)

    [final_state, buttons, joltage]
  end

  def press(status, button)
    new_status = status.clone
    button.each do |i|
      new_status[i] ^= true
    end
    new_status
  end

  def solve2(input)
    input.map{|line|clicks_to_joltage(line)}
         .sum
  end

  def clicks_to_joltage(line)
    final_state, buttons, joltage = decode_machine(line)
    buttons.sort!{|b1, b2| b2.size <=> b1.size}
    find(buttons, joltage)
  end

  def press2(status, button, times)
    new_status = status.clone
    button.each do |i|
      new_status[i] += times
    end
    new_status
  end

  def smaller?(new_state, final_state)
    new_state.zip(final_state).all?{|counters| counters[0] <= counters[1]}
  end

  def find(buttons, final_state)
    already_clicked = []
    fixed_clicks = 0
    next_state = Array.new(final_state.size, 0)
    buttons.flatten.tally.select {|k,v| v == 1}.each do |i|
      button = buttons.select{|b| b.include?(i)}[0]
      times = final_state[i]
      next_state = press2(state, button, times)
      fixed_clicks += times
    end
    find(next_state, buttons - already_clicked, final_state, final_state.sum, fixed_clicks)
  end

  def find_min(state, buttons, final_state, min, clicks)
    return min if clicks >= min
    return clicks if state == final_state
    return min if buttons.empty?
    return min if !viable?(state, final_state, buttons)
    local_min = min
    (min - clicks).downto(0).each do |times|
      new_state = press2(state, buttons[0], times)
      next unless smaller?(new_state, final_state)
      local_min = find_min(new_state, buttons[1..], final_state, local_min, clicks + times)
    end
    local_min
  end

  def viable?(state, final_state, buttons)
    needed = (0..(state.size() - 1)).select {|i| state[i] != final_state[i]}
    available = buttons.flatten.uniq
    needed.all?{|i| available.include?(i) }
  end
end
