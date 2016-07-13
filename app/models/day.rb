class Day < ActiveRecord::Base
  belongs_to :users
  has_many :symptoms
  has_many :entries
  validates :day, presence: true

  def create_day_before(current_user)
    d = Day.new
    d.day = self.day - 86400
    d.user_id = current_user.id
    d.save
  end

  def create_day_after(current_user)
    d = Day.new
    d.day = self.day + 86400
    d.user_id = current_user.id
    d.save
  end

end
