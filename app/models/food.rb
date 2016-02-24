class Food < ActiveRecord::Base
  has_many :ingredients, as: :foodlike
  belongs_to :meals

  validates :product_name, presence: true

end
