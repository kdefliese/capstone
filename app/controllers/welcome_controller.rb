class WelcomeController < ApplicationController
  before_action :require_login, only: [:index]
  before_action :current_user, only: [:index]
  before_action :current_day_for_user, only: [:index]
  include FactualWrapper


  def login
  end

  def index
    today = Day.where("day = ? AND user_id = ?", Date.today, @current_user.id)
    if today.empty?
      d = Day.new
      d.day = Date.today
      d.user_id = @current_user.id
      d.save
    end
    goto = Day.where("day = ? AND user_id = ?", Date.today, @current_user.id)[0]
    redirect_to day_path(goto.id)
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
