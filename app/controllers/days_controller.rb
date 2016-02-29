class DaysController < ApplicationController

  def show
    @day = Day.find(params[:id])
    @entries = @day.entries
    @entry = Entry.new
    @food = Food.new
    @all_meals = Meal.all
    @all_foods = Food.all
    @all_ingredients = Ingredient.all
  end

end
