class AddRelationshipBetweenDaysAndSymptoms < ActiveRecord::Migration
  def change
    add_column(:symptoms, :day_id, :integer)
    add_column(:symptoms, :user_id, :integer)
    add_index :symptoms, :day_id
    add_index :symptoms, :user_id
  end
end
