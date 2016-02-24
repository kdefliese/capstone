class CreateIngredients < ActiveRecord::Migration
  def change
    create_table :ingredients do |t|
      t.string :name
      t.string :sensitivity_groups, array: true

      t.timestamps null: false
    end
  end
end
