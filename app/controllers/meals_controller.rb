class MealsController < ApplicationController
  before_action :current_user
  before_action :current_day_for_user

  def new
    @meal = Meal.new
  end

  def create
    @meal = Meal.new(meal_params[:meal])
    if @meal.save
      redirect_to meal_path(@meal)
    else
      render "new"
    end
  end

  def show
    id = params[:id]
    @meal = Meal.find(id)
  end

  def all
    render :json => Meal.order("name").as_json, :status => :ok
  end

  private

  def meal_params
    params.permit(meal:[:name, :foods_list, :ingredients_list, :category])
  end

end
