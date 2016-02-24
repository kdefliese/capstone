class Ingredient < ActiveRecord::Base
  belongs_to :foodlike, polymorphic: true
  
  validates :name, presence: true
end
