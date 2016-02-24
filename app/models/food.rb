class Food < ActiveRecord::Base
  validates :product_name, presence: true
  
end
