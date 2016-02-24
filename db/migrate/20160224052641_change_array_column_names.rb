class ChangeArrayColumnNames < ActiveRecord::Migration
  def change
    rename_column(:foods, :ingredients, :ingredients_list)
    rename_column(:meals, :foods, :foods_list)
    rename_column(:meals, :ingredients, :ingredients_list)
  end
end
