class Bag
  def initialize(name, contents)
    @name = name
    @contents = {}
    if (contents != 'no other')
      contents.split(',').map{|content|
        content.split('-')
      }.each {|c| @contents[c[1]] = c[0]}
    end
  end

  def can_has_shiny_gold()
    return @contents.keys.include? 'shiny gold'
  end

  def content_names
    return @contents.keys
  end

  def contents
    return @contents
  end

end

class Processor

  def initialize
    @bag_map = {}

    lines = File.open('7.input').readlines

    lines.each do |line|
      line.strip!
      name, contents = line.split(' contain ')
      @bag_map[name] = Bag.new(name, contents)
    end

    @can_has_shiny_gold = {}

  end

  def part1
    @bag_map.keys.each do |bag_name|
      next if bag_name == 'shiny gold'
      check_can_has_shiny_gold(bag_name)
    end
    puts @can_has_shiny_gold.values.filter{|v| v}.count
  end


  def check_can_has_shiny_gold(bag_name)
    if @can_has_shiny_gold[bag_name] != nil
      return @can_has_shiny_gold[bag_name]
    end

    bag = @bag_map[bag_name]
    puts bag_name
    if bag.can_has_shiny_gold
      @can_has_shiny_gold[bag_name] = true
      return true
    end

    bag.content_names.each do |content|
      if check_can_has_shiny_gold(content)
        @can_has_shiny_gold[bag_name] = true
        return true
      end
    end

    @can_has_shiny_gold[bag_name] = false
    return false
  end

  def part2
    puts count_content('shiny gold') - 1 # the shiny gold does not count
  end

  def count_content(name)
    str = name
    bag = @bag_map[name]
    sum = 1 #this bag
    bag.contents.each do |bag_name, count|
      str += ' + ' + count + '*' + bag_name
      sum += count.to_i * count_content(bag_name)
    end
    puts str + ' ' + sum.to_s
    return sum
  end

end



Processor.new.part2
