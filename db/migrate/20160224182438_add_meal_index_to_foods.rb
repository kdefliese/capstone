class AddMealIndexToFoods < ActiveRecord::Migration
  def change
    add_column(:foods, :meal_id, :integer)
    add_index :foods, :meal_id
  end
end
