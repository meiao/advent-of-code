#!/usr/local/bin/ruby

# This program answers Advent of Code 2022 day 07
#
# This version ran in
#
# Author::    Andre Onuki
# License::   GPL3
class Solver
  def read(input)
    root = Directory.new('/', nil)
    current_dir = root
    while !input.empty?
      line = input.shift
      if line.strip == '$ cd /'
        current_dir = root
      elsif line.strip == '$ cd ..'
        current_dir = current_dir.parent
      elsif line.start_with?('$ cd ')
        current_dir = current_dir.cd(line.strip.split(' ')[2])
      elsif line.strip == '$ ls'
        loop do
          file = input.shift
          if file == nil || file.start_with?('$')
            input.unshift(file) if file != nil
            break
          end
          size, name = file.split(' ')
          if size == 'dir'
            current_dir.cd(name)
          else
            current_dir.add_file(name, size.to_i)
          end
        end
      end
    end
    root
  end

  def solve(input)
    root = read(input)
    root.small_size
  end

  def solve2(input)
    root = read(input)
    free_space = 70000000 - root.size
    space_needed = 30000000 - free_space
    root.best_dir_size(space_needed)
  end

end



class Directory
  attr_accessor :parent
  def initialize(name, parent)
    @name = name
    @parent = parent
    @sub_dirs = Hash.new { |hash, key| hash[key] = Directory.new(key, self) }
    @files = {}
  end

  def add_file(name, size)
    @files[name] = size
  end

  def cd(name)
    @sub_dirs[name]
  end

  def size
    @sub_dirs.values.map {|sub_dir| sub_dir.size}.sum + @files.values.sum
  end

  def small_size
    sub_dir_size = @sub_dirs.values.map {|sub_dir| sub_dir.small_size}.sum
    self_size = self.size()
    sub_dir_size + (self_size <=100000 ? self_size : 0)
  end

  def best_dir_size(space_needed)
    self_size = self.size
    return 70000000 if self_size < space_needed

    min = 70000000
    @sub_dirs.values.each do |sub_dir|
      best_subdir_size = sub_dir.best_dir_size(space_needed)
      min = best_subdir_size if best_subdir_size < min
    end
    min = self_size if self_size < min
    min
  end

end
