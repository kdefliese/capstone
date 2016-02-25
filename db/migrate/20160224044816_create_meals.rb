class CreateMeals < ActiveRecord::Migration
  def change
    create_table :meals do |t|
      t.string :name
      t.string :foods, array: true
      t.string :ingredients, array: true
      t.string :category
      t.integer :user_id

      t.timestamps null: false
    end

    add_index(:meals, :user_id)
  end
end
