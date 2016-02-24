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
  {brand: "Amy's", product_name: "Refried Beans", ingredients_list: ["pinto beans, pork lard"], category: "Dinner", sensitivity_groups: ["beans","nitrates"]},
  {brand: "Tostitos", product_name: "Tortillas", ingredients_list: ["flour"], category: "Dinner", sensitivity_groups: ["gluten"]},
  {brand: "El Paso", product_name: "Taco Seasoning", ingredients_list: ["cumin","chili pepper"], category: "Dinner", sensitivity_groups: ["spicy foods"]}
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
