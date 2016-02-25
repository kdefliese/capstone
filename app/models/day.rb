class Day < ActiveRecord::Base
  has_and_belongs_to_many :meals
  validates :date, presence: true, uniqueness: true
end
