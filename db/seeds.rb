# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


seed_ingredients = [
  {name: "ground turkey", sensitivity_groups: ["processed meat"]},
  {name: "cheese", sensitivity_groups: ["dairy"]},
  {name: "cumin", sensitivity_groups: []},
  {name: "chili pepper", sensitivity_groups: ["spicy foods"]},
  {name: "flour", sensitivity_groups: ["gluten"]},
  {name: "salt", sensitivity_groups: []},
  {name: "pinto beans", sensitivity_groups: ["beans"]},
  {name: "pork lard", sensitivity_groups: ["nitrates"]}
]

seed_ingredients.each do |ing|
  Ingredient.create(ing)
end

seed_foods = [
  {brand: "Amy's", name: "Refried Beans", ingredients_list: ["pinto beans, pork lard"], category: "Dinner", sensitivity_groups: ["beans","nitrates"]},
  {brand: "Tostitos", name: "Tortillas", ingredients_list: ["flour"], category: "Dinner", sensitivity_groups: ["gluten"]},
  {brand: "El Paso", name: "Taco Seasoning", ingredients_list: ["cumin","chili pepper"], category: "Dinner", sensitivity_groups: ["spicy foods"]}
]

seed_foods.each do |f|
  Food.create(f)
end

Food.find(1).ingredients << [Ingredient.find(7), Ingredient.find(8)]
Food.find(2).ingredients << Ingredient.find(5)
Food.find(3).ingredients << [Ingredient.find(3), Ingredient.find(4)]

seed_meals = [
  {name: "Turkey Tacos", foods_list: [], ingredients_list: [], category: "Dinner"},
  {name: "Breakfast Tacos", foods_list: [], ingredients_list: [], category: "Breakfast"}
]

seed_meals.each do |m|
  Meal.create(m)
end

Meal.find(1).foods << [Food.find(1),Food.find(2),Food.find(3)]
Meal.find(1).ingredients << [Ingredient.find(1),Ingredient.find(2)]

Meal.find(2).foods << [Food.find(1),Food.find(2),Food.find(3)]
Meal.find(2).ingredients << [Ingredient.find(1),Ingredient.find(2)]


seed_days = [
  {day: DateTime.new(2016,2,1), user_id: 1},
]

seed_days.each do |d|
  Day.create(d)
end

seed_entries = [
  {time: DateTime.new(2016,2,1,1,2,3), user_id: 1, day_id: 1, category: "Breakfast", notes: "Mmm food"},
  {time: DateTime.new(2016,2,1,4,5,6), user_id: 1, day_id: 1, category: "Lunch", notes: "Good notes"}
]

seed_entries.each do |e|
  Entry.create(e)
end

Day.find(1).entries << [Entry.find(1),Entry.find(2)]

Entry.find(1).meals << Meal.find(1)
Entry.find(2).meals << Meal.find(2)
