class AddJoinTableForDaysAndMeals < ActiveRecord::Migration
  def change
    create_table :days_meals, id: false do |t|
      t.integer :day_id
      t.integer :meal_id
    end

    add_index :days_meals, :day_id
    add_index :days_meals, :meal_id
  end
end
