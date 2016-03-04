class DaysController < ApplicationController
  before_action :current_user
  before_action :current_day_for_user

  def show
    # need to make sure this method only shows entries and symptoms for that user on that day
    @day = Day.find(params[:id])
    @day_id = @day.id
    @user_id = @current_user.id
    @entries = @current_user.entries.where("day_id = ?", @day_id).order("time")
    @entry = Entry.new
    @all_meals = @current_user.meals.order("name")
    @all_foods = Food.all
    @all_ingredients = Ingredient.all
    @symptom = Symptom.new
    @symptoms = @current_user.symptoms.where("day_id = ?", @day_id)
  end

  private

  def day_params
    params.permit(:day, :user_id)
  end


end
