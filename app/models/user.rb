class User < ActiveRecord::Base
  has_many :days
  has_many :entries
  has_many :symptoms
  has_many :meals

  validates :uid, presence: true, uniqueness: true
  validates :provider, presence: true
  # validates :email, presence: true

  def self.find_or_create_from_omniauth(auth_hash)
    user = self.find_by(uid: auth_hash["uid"], provider: auth_hash["provider"])
    if !user.nil?
      return user
    else
      user = User.new
      user.uid = auth_hash["uid"]
      user.provider = auth_hash["provider"]
      user.name = auth_hash["info"]["name"]
      user.image = auth_hash["info"]["image"]
      user.email = auth_hash["info"]["email"]
      if user.save
        create_initial_days_for_user
        return user
      else
        return nil
      end
    end
  end

  private

  def create_initial_days_for_user
    # create yesterday
    y = Day.new
    y.day = Date.today.advance(:days => -1)
    y.user_id = user.id
    y.save
    # create today
    d = Day.new
    d.day = Date.today
    d.user_id = user.id
    d.save
    # create tomorrow
    t = Day.new
    t.day = Date.today.advance(:days => 1)
    t.user_id = user.id
    t.save
  end

end
