class Food < ActiveRecord::Base
  has_and_belongs_to_many :ingredients
  has_and_belongs_to_many :meals
  has_and_belongs_to_many :entries

  validates :product_name, presence: true

end
