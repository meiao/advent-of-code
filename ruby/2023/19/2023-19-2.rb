#!/usr/local/bin/ruby

# This program answers Advent of Code 2023 day 19
#
# Author::    Andre Onuki
# License::   GPL3
class Solver2
  def solve(workflow_data)
    workflows = parse_workflows(workflow_data)
    evaluate(workflows)
  end

  def parse_workflows(workflow_data)
    workflows = {}
    workflow_data.each do |data|
      name, rules = data.split('{')
      workflows[name] = Workflow.new(rules[0..-2])
    end
    workflows
  end

  def evaluate(workflows)
    sum = 0

    queue = [[{
      'x' => (1..4000),
      'm' => (1..4000),
      'a' => (1..4000),
      's' => (1..4000)
      }, 'in']]
    until queue.empty?
      part, wkf = queue.pop
      next if wkf == 'R'
      if wkf == 'A'
        sum += calculate(part)
        next
      end
      workflow = workflows[wkf]
      result = workflow.evaluate(part)
      p result
      sum += result[0]
      queue.concat(result[1])
    end
    sum
  end

  def calculate(part)
    part.values.map{|range| range.size}.inject(:*)
  end

end

class Workflow
  def initialize(data)
    @rules = []
    data.split(',').each do |rule|
      if rule.include? ':'
        cond, result = rule.split(':')
        /(?<var>[xmas])(?<operator>[<>])(?<v>\d+)/ =~ cond
        value = v.to_i
        @rules << [var, operator, value, result]
      else
        @rules << [nil, nil, nil, rule]
      end
    end
  end

  def evaluate(part)
    sum = 0
    next_parts = []
    @rules.each do |rule|
      if rule[0] == nil
        next_parts << [part, rule[3]]
        break
      else
        parts = split(part, rule[0], rule[1], rule[2])
        part = parts[0]
        next_parts << [parts[1], rule[3]] if parts.size > 1
      end
    end
    [sum, next_parts]
  end

  def split(part, var, operator, value)
    return [part] unless part[var].include? value
    ranges = []
    range = part[var]
    if operator == '>'
      ranges << (range.first..value)
      ranges << (value.succ..range.last)
    else
      ranges << (value..range.last)
      ranges << (range.first..value.pred)
    end
    matching_part = part.clone
    other_part = part.clone
    other_part[var] = ranges[0]
    matching_part[var] = ranges[1]
    [other_part, matching_part]
  end
end
