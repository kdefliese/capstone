class Meal < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_and_belongs_to_many :foods
  has_and_belongs_to_many :ingredients

  validates :name, presence: true
end
