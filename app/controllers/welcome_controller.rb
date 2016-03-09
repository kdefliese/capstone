class WelcomeController < ApplicationController
  before_action :require_login, except: [:login, :about]
  before_action :current_user, only: [:index]
  before_action :current_day_for_user, except: [:login, :about]
  include FactualWrapper


  def login
  end

  def index
  end

  def about
  end

end
