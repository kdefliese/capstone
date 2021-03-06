class WelcomeController < ApplicationController
  before_action :require_login, only: [:index]
  before_action :current_user, only: [:index]
  before_action :current_day_for_user, only: [:index]
  include FactualWrapper


  def login
  end

  def index
    redirect_to current_day_path(@current_user.id)
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
