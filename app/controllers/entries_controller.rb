class EntriesController < ApplicationController

  def create
    @entry = Entry.new(entry_params)
    if @entry.save
      if !params[:meal_ids].nil?
        params[:meal_ids].each do |i|
          @entry.meals << Meal.find(i.to_i)
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
