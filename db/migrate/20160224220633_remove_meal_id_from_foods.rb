class RemoveMealIdFromFoods < ActiveRecord::Migration
  def change
    remove_column(:foods, :meal_id, :integer)
  end
end
