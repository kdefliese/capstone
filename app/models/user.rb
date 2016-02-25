class User < ActiveRecord::Base
  has_many :days
  has_many :entries
  has_many :symptoms

  validates :uid, presence: true, uniqueness: true
  validates :provider, presence: true
  # validates :email, presence: true

  def self.find_or_create_from_omniauth(auth_hash)
    user = self.find_by(uid: auth_hash["uid"], provider: auth_hash["provider"])
    if !user.nil?
      # user found, return user
      return user
    else
      # create a new user
      user = User.new
      user.uid = auth_hash["uid"]
      user.provider = auth_hash["provider"]
      user.name = auth_hash["info"]["name"]
      user.image = auth_hash["info"]["image"]
      user.email = auth_hash["info"]["email"]
      if user.save
        return user
      else
        return nil
      end
    end
  end

end
