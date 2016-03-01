class EntriesController < ApplicationController

  def create
    date = Day.find(params[:day_id]).day.to_s.slice(0,10)
    entry_time = params[:time]
    entry_datetime = DateTime.parse(date + " " + entry_time)
    @entry = Entry.new(entry_params)
    @entry.time = entry_datetime
    binding.pry
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
      redirect_to day_path(Day.find(1))
    else

    end
  end

  private

  def entry_params
    params.permit(:time, :category, :notes, :user_id, :day_id)
  end

end
