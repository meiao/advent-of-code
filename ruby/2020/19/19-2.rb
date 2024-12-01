class Processor
  def initialize
    @memoize = []
    @lines = File.open('19.rules2').readlines
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
          print rule_number if number == 0
          puts new_strs if number == 0
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

    @memoize[number] = Array.new(calculated)
    puts calculated if number == 0
    Array.new(calculated)
  end

  def part2
    rules42 = calc_rule(42)
    rules31 = calc_rule(31)

    str42 = rules42.map { |r| '(' + r + ')' }.join('|')
    str31 = rules31.map { |r| '(' + r + ')' }.join('|')
    regexps = []
    8.times do |i|
      num42 = (i + 2).to_s
      num31 = (i + 1).to_s
      regexps << Regexp.new('^(' + str42 + '){' + num42 + ',}(' + str31 + '){' + num31 + '}$')
    end

    words = File.open('19.words').readlines
    valid_word_count = 0
    words.each do |word|
      valid = false
      regexps.each do |re|
        unless re.match(word.strip).nil?
          valid = true
          break
        end
      end
      valid_word_count += 1 if valid
    end

    puts valid_word_count
  end
end

p = Processor.new
p.part2
