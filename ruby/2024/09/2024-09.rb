#!/usr/local/bin/ruby

# This program answers Advent of Code 2024 day 09
#
# Author::    Andre Onuki
# License::   GPL3
class Solver
  def solve(input)
    disk_map = input[0].strip.split('').map(&:to_i)
    # if there is an even number of entries, the last entry is for empty space
    disk_map.pop if disk_map.size.even?
    memory = []
    i = 0
    loop do
      break if i >= disk_map.size

      # when i is even, the position holds a file
      if i.even?
        disk_map[i].times { memory << i / 2 }
        i += 1
        # below, it is a empty space, so try to move the last file in
      elsif disk_map[i] == disk_map[-1]
        disk_map[i].times { memory << disk_map.size / 2 }
        disk_map.pop(2)
        i += 1
      elsif disk_map[i] < disk_map[-1]
        disk_map[i].times { memory << disk_map.size / 2 }
        disk_map[-1] -= disk_map[i]
        i += 1
      else # disk_map[i] > disk_map[-1]
        disk_map[-1].times { memory << disk_map.size / 2 }
        disk_map[i] -= disk_map[-1]
        disk_map.pop(2)
      end
    end
    checksum(memory)
  end

  def checksum(memory)
    checksum = 0
    (1..(memory.size - 1)).each do |i|
      checksum += i * memory[i]
    end
    checksum
  end

  def solve2(input)
    disk_map = input[0].strip.split('').map(&:to_i)
    disk_map.pop if disk_map.size.even?
    # the array of file info, the index is the file id
    # each value is an array with the start index and length of the file
    files = []

    # map of free space, key is the start index of the free space, value is the length
    free_space = {}
    next_memory = 0
    disk_map.each_with_index do |value, i|
      next if value == 0

      if i.even?
        files << [next_memory, value]
      else
        free_space[next_memory] = value
      end
      next_memory += value
    end

    # moving the files
    (files.size - 1).downto(1).each do |i|
      next if files[i].nil?

      file_start, file_size = files[i]
      free_space.keys.sort.each do |free_start|
        # only move to the beginning of the disk
        break if free_start >= file_start

        free_size = free_space[free_start]
        next unless file_size <= free_size

        files[i][0] = free_start
        # if file was smaller than free space, create the resulting free space
        free_space[free_start + file_size] = free_size - file_size if file_size < free_size
        free_space.delete(free_start)
        break
      end
    end

    checksum2(files)
  end

  def checksum2(files)
    sum = 0
    files.each_with_index do |values, file_id|
      values[1].times do |i|
        sum += (values[0] + i) * file_id
      end
    end
    sum
  end
end
