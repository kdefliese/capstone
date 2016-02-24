class AddFoodlikeAssociation < ActiveRecord::Migration
  def change
    add_column(:ingredients, :foodlike_id, :integer)
    add_column(:ingredients, :foodlike_type, :string)

    add_index :ingredients, :foodlike_id
  end
end
