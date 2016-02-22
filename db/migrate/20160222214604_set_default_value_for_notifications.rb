class SetDefaultValueForNotifications < ActiveRecord::Migration
  def change
    change_column :users, :notifications_preference, :boolean, :default => true
  end
end
