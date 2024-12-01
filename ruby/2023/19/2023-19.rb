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
      sum += part.values.sum if evaluate(workflows, part) == 'A'
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
    until %w[A R].include?(result)
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
        @rules << if operator == '>'
                    proc { |part| part[var] > value ? result : nil }
                  else
                    proc { |part| part[var] < value ? result : nil }
                  end
      else
        @rules << proc { |_part| rule }
      end
    end
  end

  def evaluate(part)
    @rules.each do |rule|
      result = rule.call(part)
      return result unless result.nil?
    end
  end
end
