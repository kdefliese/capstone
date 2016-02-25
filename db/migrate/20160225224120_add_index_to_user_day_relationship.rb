class AddIndexToUserDayRelationship < ActiveRecord::Migration
  def change
    add_index :days, :user_id
  end
end
