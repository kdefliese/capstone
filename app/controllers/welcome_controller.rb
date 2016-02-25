class WelcomeController < ApplicationController
  before_action :require_login, except: [:login]
  include FactualWrapper


  def login
  end

  def index
    @results = get_product
  end
end
