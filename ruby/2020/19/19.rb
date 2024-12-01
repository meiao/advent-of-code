class Processor
  def initialize
    @memoize = []
    @lines = File.open('19.rules1').readlines
  end

  def calc_rule(number)
    return @memoize[number] unless @memoize[number].nil?

    rules = @lines[number].split(': ')[1].split(' | ')
    calculated = []

    rules.each do |rule|
      if rule[0] == '"'
        calculated << rule[1]
      else
        sub_rules = rule.split(' ').map { |sr| sr.to_i }

        sub_calculated = ['']
        sub_rules.each do |rule_number|
          new_strs = calc_rule(rule_number)
          next_calculated = []
          sub_calculated.each do |old_str|
            new_strs.each do |new_str|
              next_calculated << old_str + new_str
            end
          end
          sub_calculated = next_calculated
        end
        calculated.concat(sub_calculated)
      end
    end

    @memoize[number] = calculated
    calculated
  end

  def part1
    valid_words = calc_rule(0)
    words = File.open('19.words').readlines
    sum = 0
    words.each do |word|
      sum += 1 if valid_words.include?(word.strip)
    end
    puts sum
  end
end

p = Processor.new
puts p.part1
