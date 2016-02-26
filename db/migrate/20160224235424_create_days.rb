class CreateDays < ActiveRecord::Migration
  def change
    create_table :days do |t|
      t.datetime :day
      t.integer :user_id
      t.timestamps null: false
    end
  end
end
