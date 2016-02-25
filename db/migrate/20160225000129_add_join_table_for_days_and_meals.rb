class AddJoinTableForDaysAndMeals < ActiveRecord::Migration
  def change
    create_table :meals_users, id: false do |t|
      t.integer :meal_id
      t.integer :user_id
    end

    add_index :meals_users, :meal_id
    add_index :meals_users, :user_id
  end
end
