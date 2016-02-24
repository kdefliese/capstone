class CreateMeals < ActiveRecord::Migration
  def change
    create_table :meals do |t|
      t.string :name
      t.string :foods, array: true
      t.string :ingredients, array: true
      t.string :category

      t.timestamps null: false
    end
  end
end
