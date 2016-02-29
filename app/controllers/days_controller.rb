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
    @select_arr = []
    @all_meals.each do |meal|
      @select_arr.push("<option value=\"#{meal.id}\">#{meal.name}</option>")
    end
  end

end
