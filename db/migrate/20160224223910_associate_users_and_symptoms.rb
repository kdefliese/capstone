class AssociateUsersAndSymptoms < ActiveRecord::Migration
  def change
    add_column(:symptoms, :user_id, :integer)
    add_index(:symptoms, :user_id)
  end
end
