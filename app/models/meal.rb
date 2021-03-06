class Meal < ActiveRecord::Base
  has_and_belongs_to_many :foods
  has_and_belongs_to_many :ingredients
  has_and_belongs_to_many :entries
  belongs_to :users

  validates :name, presence: true
end
