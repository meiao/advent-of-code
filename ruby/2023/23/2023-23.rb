#!/usr/local/bin/ruby

# This program answers Advent of Code 2023 day 23
#
# Author::    Andre Onuki
# License::   GPL3

require_relative '../../util/grid'
class Solver
  def solve(input)
    @max = 0
    @end = [input[0].size - 3, input.size - 1]
    graph = create_graph(input, true)
    walk(graph, [[1, 0]])
  end

  def create_graph(input, filter_slopes)
    grid = Grid.new(input)
    paths = [[[1, 0], [1, 1]]]
    graph = Hash.new { |hash, key| hash[key] = {} }
    visited = Hash.new(false)
    until paths.empty?
      first_step = paths.pop
      can_go = true
      can_return = first_step[0] != [1, 0]
      step_count = 1
      step = first_step.clone
      loop do
        next_steps = grid.next_steps(step[0], step[1])
        if next_steps.size > 1
          next_steps.each { |p| paths << [step[1], p] } unless visited[step[1]]
          visited[step[1]] = true
          graph[first_step[0]][step[1]] = step_count if can_go
          graph[step[1]][first_step[0]] = step_count if can_return
          break
        elsif next_steps[0] == @end
          graph[first_step[0]][next_steps[0]] = step_count + 1 if can_go
          break
        else
          char = grid[step[1]]
          if char != '.' && filter_slopes
            diff = [step[1][0] - step[0][0], step[1][1] - step[0][1]]
            if char == '<'
              if diff == [1, 0]
                can_go = false
              else
                can_return = false
              end
            elsif char == '>'
              if diff == [1, 0]
                can_return = false
              else
                can_go = false
              end
            elsif char == 'v'
              if diff == [0, 1]
                can_return = false
              else
                can_go = false
              end
            elsif char == '^'
              if diff == [0, 1]
                can_go = false
              else
                can_return = false
              end
            end
          end

          step[0] = step[1]
          step[1] = next_steps[0]
          step_count += 1
        end
      end

    end
    graph
  end

  def walk(graph, stack)
    return calc(graph, stack) if stack[-1] == @end

    solutions = []
    graph[stack[-1]].keys.each do |next_step|
      next if stack.include? next_step

      stack << next_step
      solutions << walk(graph, stack)
      stack.pop
    end
    return 0 if solutions.empty?

    solutions.max
  end

  def calc(graph, stack)
    sum = 0
    0.upto(stack.size - 2).each do |i|
      sum += graph[stack[i]][stack[i + 1]]
    end
    if sum > @max
      @max = sum
      p sum
    end
    sum
  end

  def solve2(input)
    @max = 0
    @end = [input[0].size - 3, input.size - 1]
    graph = create_graph(input, false)
    walk(graph, [[1, 0]])
  end
end
