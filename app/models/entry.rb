class Entry < ActiveRecord::Base
  belongs_to :days
  belongs_to :users
end
