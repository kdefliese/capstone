class Meal < ActiveRecord::Base
  validates :name, presence: true
end
