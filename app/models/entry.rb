class Entry < ActiveRecord::Base
  belongs_to :days
  belongs_to :users
  has_and_belongs_to_many :meals
  has_and_belongs_to_many :foods
  has_and_belongs_to_many :ingredients
end
