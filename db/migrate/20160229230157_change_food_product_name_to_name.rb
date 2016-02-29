class ChangeFoodProductNameToName < ActiveRecord::Migration
  def change
    rename_column(:foods,:product_name,:name)
  end
end
