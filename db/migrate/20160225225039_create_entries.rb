class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.time :time
      t.integer :user_id
      t.integer :day_id
      t.string :category
      t.text :notes

      t.timestamps null: false
    end

    add_index(:entries,:day_id)
    add_index(:entries,:user_id)
  end
end
