class RemoveFoodlikeFieldsFromIngredients < ActiveRecord::Migration
  def change
    remove_column(:ingredients, :foodlike_id, :integer)
    remove_column(:ingredients, :foodlike_type, :string)
  end
end
