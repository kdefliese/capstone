class Day < ActiveRecord::Base
  belongs_to :users
  has_many :symptoms
  has_many :entries
  validates :day, presence: true
end
