lines = File.open('21.input').readlines

ingredient_set = {}
allergen_map = {}
all_ingredients = []

lines.each do |line|
  ingredient_list, allergen_list = line.split(' = ')
  ingredients = ingredient_list.split(' ')
  allergens = allergen_list.split(' ')
  ingredients.each do |ingredient|
    ingredient_set[ingredient] = true
  end

  all_ingredients.concat(ingredients)

  allergens.each do |allergen|
    allergen_map[allergen] = [] if allergen_map[allergen] == nil
    allergen_map[allergen] << ingredients
  end
end

known_allergen = {}

allergen_map.keys.each do |allergen|
  recipes = allergen_map[allergen]
  ingredients = recipes.shift
  while !recipes.empty?
    next_ingredients = recipes.shift
    ingredients = ingredients.filter{|ingredient| next_ingredients.include?(ingredient)}
  end
  if ingredients.size == 1
    known_allergen[allergen] = ingredients[0]
    allergen_map.delete(allergen)
  else
    allergen_map[allergen] = ingredients
  end
end

while !allergen_map.empty?
  allergen_map.keys.each do |allergen|
    ingredients = allergen_map[allergen]
    known_allergen.values.each do |ingredient|
      ingredients.delete(ingredient)
    end
    if ingredients.size == 1
      known_allergen[allergen] = ingredients[0]
      allergen_map.delete(allergen)
    else
      allergen_map[allergen] = ingredients
    end
  end
end

non_allergen_count = all_ingredients.count
known_allergen.values.each do |allergen|
  non_allergen_count -= all_ingredients.count(allergen)
end

puts non_allergen_count

known_allergen.keys.sort.each do |allergen|
  print known_allergen[allergen] + ','
end
