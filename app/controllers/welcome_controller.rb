class WelcomeController < ApplicationController
  before_action :require_login, only: [:index]
  before_action :current_user, only: [:index]
  before_action :current_day_for_user, only: [:index]
  include FactualWrapper


  def login
  end

  def index
    if @current_day.nil?
      d = Day.new
      d.day = Date.today
      d.user_id = @current_user.id
      d.save
    end
  end

  def about
  end

  def letsencrypt
    render plain: ENV['LE_AUTH_RESPONSE']
  end

end
