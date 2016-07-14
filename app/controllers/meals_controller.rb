class MealsController < ApplicationController
  before_action :current_user
  before_action :current_day_for_user

  def new
    @meal = Meal.new
    @all_foods = Food.all
  end

  def create
    @meal = Meal.new(meal_params)
    if @meal.save
      add_or_update_foods_in_meal
      add_or_update_ingredients_in_meal
    end
    render nothing: true
  end

  def index
    @meals = @current_user.meals
  end

  def show
    id = params[:id]
    @meal = Meal.find(id)
  end

  def edit
    id = params[:id]
    @meal = Meal.find(id)
    @all_foods = Food.all
    @all_ingredients = Ingredient.all
  end

  def update
    @meal = Meal.find(params[:id])
    @meal.foods = []
    @meal.ingredients = []
    if @meal.update(meal_params)
      add_or_update_foods_in_meal
      add_or_update_ingredients_in_meal
      render nothing: true
    end
  end

  def destroy
    @meal = Meal.find(params[:id])
    @meal.destroy
    redirect_to meals_path
  end

  def all
    render :json => @current_user.meals.order("name").as_json, :status => :ok
  end

  def last
    meal = @current_user.meals.last
    render :json => {:meal => meal.as_json, :foods => meal.foods.as_json, :ingredients => meal.ingredients.as_json}, :status => :ok
  end

  private

  def meal_params
    params.permit(:id, :name, :user_id, :category)
  end

  def add_or_update_foods_in_meal
    if !params[:food_ids].nil? && !params[:food_ids].empty?
      params[:food_ids].each do |i|
        @meal.foods << Food.find(i.to_i)
      end
    end
  end

  def add_or_update_ingredients_in_meal
    if !params[:ingredient_ids].nil? && !params[:ingredient_ids].empty?
      params[:ingredient_ids].each do |i|
        @meal.ingredients << Ingredient.find(i.to_i)
      end
    end
  end

end
