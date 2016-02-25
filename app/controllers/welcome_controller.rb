class WelcomeController < ApplicationController
  before_action :require_login, except: [:login]
  include FactualWrapper


  def login
  end

  def index
    @ingredients = Ingredient.all
    @foods = Food.all
    @meals = Meal.all
  end
end
