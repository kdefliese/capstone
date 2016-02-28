class WelcomeController < ApplicationController
  before_action :require_login, except: [:login]
  before_action :current_user, only: [:index]
  include FactualWrapper


  def login
  end

  def index
    @ingredients = Ingredient.all
    @foods = Food.all
    @meals = Meal.all
  end
end
