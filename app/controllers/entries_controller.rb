class EntriesController < ApplicationController
  before_action :current_user
  before_action :current_day_for_user

  def create
    date = Day.find(params[:day_id]).day.to_s.slice(0,10)
    entry_time = params[:time]
    entry_datetime = DateTime.parse(date + " " + entry_time)
    @entry = Entry.new(entry_params)
    @entry.time = entry_datetime
    if @entry.save
      if !params[:meal_ids].nil?
        params[:meal_ids].each do |i|
          @entry.meals << Meal.find(i.to_i)
        end
      end
      if !params[:food_ids].nil?
        params[:food_ids].each do |i|
          @entry.foods << Food.find(i.to_i)
        end
      end
      if !params[:ingredient_ids].nil?
        params[:ingredient_ids].each do |i|
          @entry.ingredients << Ingredient.find(i.to_i)
        end
      end
      redirect_to day_path(Day.find(params[:day_id]))
    else
      flash[:error] = "We couldn't save your entry! Please try again."
    end
  end

  def last
    entry = Entry.last
    entry_time = entry.time.strftime("%l:%M %p")
    render :json => {:entry => entry.as_json, :entry_time => entry_time.as_json, :meals => entry.meals.as_json, :foods => entry.foods.as_json, :ingredients => entry.ingredients.as_json}, :status => :ok
  end

  def update
  end

  def destroy
    @entry = Entry.find(params[:id])
    @entry.destroy
    redirect_to day_path(1)
  end

  private

  def entry_params
    params.permit(:time, :category, :notes, :user_id, :day_id)
  end

end
