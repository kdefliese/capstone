class CreateJoinTables < ActiveRecord::Migration
  def change
    create_table :foods_ingredients, id: false do |t|
      t.integer :food_id
      t.integer :ingredient_id
    end

    create_table :foods_meals, id: false do |t|
      t.integer :food_id
      t.integer :meal_id
    end

    create_table :ingredients_meals, id: false do |t|
      t.integer :ingredient_id
      t.integer :meal_id
    end

    add_index :foods_ingredients, :food_id
    add_index :foods_ingredients, :ingredient_id
    add_index :foods_meals, :food_id
    add_index :foods_meals, :meal_id
    add_index :ingredients_meals, :ingredient_id
    add_index :ingredients_meals, :meal_id
  end
end
