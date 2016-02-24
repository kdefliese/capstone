class Food < ActiveRecord::Base
  has_many :ingredients, as: :foodlike

  validates :product_name, presence: true

end
