#!/usr/local/bin/ruby

# This program answers Advent of Code 2023 day 19
#
# Author::    Andre Onuki
# License::   GPL3
class Solver
  def solve(workflow_data, parts_data)
    workflows = parse_workflows(workflow_data)
    sum = 0
    parts_data.each do |data|
      part = parse_part(data)
      if evaluate(workflows, part) == 'A'
        sum += part.values.sum
      end
    end
    sum
  end

  def parse_part(data)
    part = {}
    data[1..-2].split(',').each do |expr|
      var, value = expr.split('=')
      part[var] = value.to_i
    end
    part
  end

  def parse_workflows(workflow_data)
    workflows = {}
    workflow_data.each do |data|
      name, rules = data.split('{')
      workflows[name] = Workflow.new(rules[0..-2])
    end
    workflows
  end

  def evaluate(workflows, part)
    result = 'in'
    until result == 'A' || result == 'R'
      workflow = workflows[result]
      result = workflow.evaluate(part)
    end
    result
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
        if operator == '>'
          @rules << Proc.new {|part| part[var] > value ? result : nil}
        else
          @rules << Proc.new {|part| part[var] < value ? result : nil}
        end
      else
        @rules << Proc.new {|part| rule}
      end
    end
  end

  def evaluate(part)
    @rules.each do |rule|
      result = rule.call(part)
      return result if result != nil
    end
  end
end
