class AssociateThingsToEntries < ActiveRecord::Migration
  def change
    create_table :entries_meals, id: false do |t|
      t.integer :entry_id
      t.integer :meal_id
    end

    create_table :entries_foods, id: false do |t|
      t.integer :entry_id
      t.integer :food_id
    end

    create_table :entries_ingredients, id: false do |t|
      t.integer :entry_id
      t.integer :ingredient_id
    end

    add_index :entries_meals, :entry_id
    add_index :entries_meals, :meal_id
    add_index :entries_foods, :entry_id
    add_index :entries_foods, :food_id
    add_index :entries_ingredients, :entry_id
    add_index :entries_ingredients, :ingredient_id
  end
end
