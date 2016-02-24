class ChangeDatetimeFieldsToTime < ActiveRecord::Migration
  def change
    change_column(:symptoms,:start_time,:time)
    change_column(:symptoms,:end_time,:time)
  end
end
