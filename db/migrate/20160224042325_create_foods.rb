class CreateFoods < ActiveRecord::Migration
  def change
    create_table :foods do |t|
      t.string :brand
      t.string :product_name
      t.string :ingredients, array: true
      t.string :manufacturer 
      t.string :category
      t.string :ean13
      t.string :upc
      t.string :factual_id
      t.string :image_urls
      t.string :sensitivity_groups, array: true

      t.timestamps null: false
    end
  end
end
