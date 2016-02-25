class Symptom < ActiveRecord::Base
  belongs_to :days
  validates :name, presence: true
  validates :start_time, presence: true
end
