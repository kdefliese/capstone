class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :uid
      t.string :provider
      t.string :email
      t.integer :phone
      t.string :name
      t.string :image
      t.string :known_intolerances, array: true
      t.string :watching, array: true
      t.string :medical_disorders, array: true
      t.boolean :notifications_preference

      t.timestamps null: false
    end
  end
end
