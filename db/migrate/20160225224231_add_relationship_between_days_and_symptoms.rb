class AddRelationshipBetweenDaysAndSymptoms < ActiveRecord::Migration
  def change
    add_column(:symptoms, :day_id, :integer)
    add_index :symptoms, :day_id
  end
end
