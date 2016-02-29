class DaysController < ApplicationController
  before_action :current_user

  def show
    @day = Day.find(params[:id])
    @entries = @day.entries
    @entry = Entry.new
    @food = Food.new
    @all_meals = @current_user.meals
    @all_foods = Food.all
    @all_ingredients = Ingredient.all
  end


end
