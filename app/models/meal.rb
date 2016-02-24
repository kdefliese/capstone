class Meal < ActiveRecord::Base
  has_many :foods
  has_many :ingredients, as: :foodlike

  validates :name, presence: true
end
