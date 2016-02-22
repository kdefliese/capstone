class User < ActiveRecord::Base
  validates :uid, presence: true, uniqueness: true
  validates :provider, presence: true

end
