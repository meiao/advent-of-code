class Solver
  @@neighbors = [[-1,1], [0,1], [1,1],
                 [-1,0],        [1,0],
                 [-1,-1],[0,-1],[1,-1]]


  def solve(input, repeat)
    map = create_map(input)

    initial_rolls = map.size

    # first iteration, check all the rolls
    keys_to_check = map.keys

    loop do
      removable_keys = keys_to_check.select{|key| can_remove?(map, key)}

      removable_keys.each {|key|map.delete(key)}
      break unless repeat && !removable_keys.empty?

      # for the next iteration, only rows neighboring a removed roll will be checked
      keys_to_check = affected_keys(map, removable_keys)
    end
    initial_rolls - map.size
  end

  def create_map(input)
    map = Hash.new(false)
    input.length.times do |y|
      input[y].length.times do |x|
        map[[x,y]] = true if input[y][x] == '@'
      end
    end
    map
  end

  def can_remove?(map, key)
    neighboring = @@neighbors.map{|dir| [key[0] + dir[0], key[1] + dir[1]]}
                             .select{|pos| map[pos]}
    neighboring.size < 4
  end

  def affected_keys(map, removed_keys)
    affected_keys = Hash.new(false)
    removed_keys.each do |key|
      @@neighbors.map{|dir| [key[0] + dir[0], key[1] + dir[1]]} # neighbors of a removed roll
                 .select{|pos| map[pos]}                        # keep only positions that currently have a roll
                 .each{|pos| affected_keys[pos] = true}         # save to "set"
    end
    affected_keys.keys
  end
end
