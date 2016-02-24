class CreateSymptoms < ActiveRecord::Migration
  def change
    create_table :symptoms do |t|
      t.string :name
      t.integer :severity
      t.datetime :start_time
      t.datetime :end_time
      t.text :notes

      t.timestamps null: false
    end
  end
end
