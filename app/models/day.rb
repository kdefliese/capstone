class Day < ActiveRecord::Base
  belongs_to :users
  has_many :symptoms
  validates :date, presence: true
end
