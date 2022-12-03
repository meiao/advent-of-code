class Action
  def initialize(line)
    match = line.match(/[^\d]+/)
    case match.to_s.strip
    when 'turn on'
      @action = -> (cur_state) {true}
      @brightness = 1
    when 'toggle'
      @action = -> (cur_state) {!cur_state}
      @brightness = 2
    else
      @action = -> (cur_state) {false}
      @brightness = -1
    end

    @x1, @y1, @x2, @y2 = match.post_match
      .split(' through ')
      .collect {|c| c.split(',')}
      .flat_map {|c| c }
      .map {|c| c.to_i}
  end

  def applies?(x, y)
    return @x1 <= x && x <= @x2 && @y1 <= y && y <= @y2
  end

  def apply(cur_state)
    return @action.call(cur_state)
  end

  def brightness
    @brightness
  end
end



actions = File.open('6.input').readlines.map{|line| Action.new(line)}

lit_up = 0
total_brightness = 0
(0..999).each do |x|
  (0..999).each do |y|
    cur_state = false
    brightness = 0
    actions.each do |action|
      if action.applies?(x, y)
        cur_state = action.apply(cur_state)
        brightness += action.brightness
        brightness = 0 if brightness < 0
      end
    end

    lit_up += 1 if cur_state
    total_brightness += brightness
  end
end

puts lit_up
puts total_brightness
