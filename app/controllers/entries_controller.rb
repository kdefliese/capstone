class EntriesController < ApplicationController

  def create
    @entry = Entry.new(entry_params)
    binding.pry
    if @entry.save
      @entry.meals << Meal.find(params[:meal_id])
      redirect_to day_path(Day.find(1))
    else

    end
  end

  private

  def entry_params
    params.permit(:time, :category, :notes, :user_id, :day_id)
  end

end
