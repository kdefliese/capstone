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
    redirect_to day_path(@current_day.id)
  end

  def about
    if session[:user_id]
      current_user
      current_day_for_user
    end
  end

  def letsencrypt
    render plain: ENV['LE_AUTH_RESPONSE']
  end

end
