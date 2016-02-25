class Day < ActiveRecord::Base
  belongs_to :users
  has_many :symptoms
  has_many :entries
  validates :date, presence: true
end
