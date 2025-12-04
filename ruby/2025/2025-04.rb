class Solver
  def solve(input, repeat)
    map = Hash.new(0)
    input.length.times do |y|
      input[y].length.times do |x|
        map[[x,y]] = 1 if input[y][x] == '@'
      end
    end

    neighbors = [[-1,1], [0,1], [1,1],
                 [-1,0],        [1,0],
                 [-1,-1],[0,-1],[1,-1]]
    initial_rolls = map.size

    loop do
      removable_keys = []

      # could speed up a little if after the first removal, only check the keys neighboring the rolls that 
      # were removal on the previous iteration
      map.keys.each do |key|
        neighboring = neighbors.map{|dir| [key[0] + dir[0], key[1] + dir[1]]}
                               .map{|pos| map[pos]}
                               .sum
        removable_keys << key if neighboring < 4
      end
      removable_keys.each do |key|
        map.delete(key)
      end
      break unless repeat && !removable_keys.empty?
    end
    initial_rolls - map.size
  end
end
