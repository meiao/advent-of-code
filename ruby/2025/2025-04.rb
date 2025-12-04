class Solver
  @@neighbors = [[-1,1], [0,1], [1,1],
                 [-1,0],        [1,0],
                 [-1,-1],[0,-1],[1,-1]]


  def solve(input, repeat)
    map = Hash.new(false)
    input.length.times do |y|
      input[y].length.times do |x|
        map[[x,y]] = true if input[y][x] == '@'
      end
    end

    initial_rolls = map.size

    # first iteration, check all the rolls
    keys_to_check = map.keys

    loop do
      removable_keys = []

      keys_to_check.each do |key|
        neighboring = @@neighbors.map{|dir| [key[0] + dir[0], key[1] + dir[1]]}
                                 .select{|pos| map[pos]}
                                 .size
        removable_keys << key if neighboring < 4
      end
      removable_keys.each{|key|map.delete(key)}

      break unless repeat && !removable_keys.empty?
      # for the next iteration, only rows neighboring a removed roll will be checked
      keys_to_check = affected_keys(map, removable_keys)
    end
    initial_rolls - map.size
  end

  def affected_keys(map, removed_keys)
    affected_keys = Hash.new(false)
    removed_keys.each do |key|
      @@neighbors.map{|dir| [key[0] + dir[0], key[1] + dir[1]]}
                 .select{|pos| map[pos]}
                 .each{|pos| affected_keys[pos] = true}
    end
    affected_keys.keys
  end
end
