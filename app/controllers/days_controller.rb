class DaysController < ApplicationController
  before_action :current_user
  before_action :current_day_for_user

  def show
    # what if this day ID doesn't exist yet?
    @day = Day.find(params[:id])
    # if this day doesn't belong to this user, redirect to today for this user
    if @day.user_id != @current_user.id
      redirect_to day_path(@current_day.id)
    else
      day_before = @day.day - 86400
      check_day_before = @current_user.days.where("day = ? AND user_id = ?", day_before, @current_user.id)
      if check_day_before.empty?
        # create day before for this user
        d = Day.new
        d.day = @day.day - 86400
        d.user_id = @current_user.id
        d.save
      end
      days_array = @current_user.days.where("day = ? AND user_id = ?", day_before, @current_user.id)
      @day_before = days_array[0]
      # now repeat with day after
      day_after = @day.day + 86400
      check_day_after = @current_user.days.where("day = ? AND user_id = ?", day_after, @current_user.id)
      if check_day_after.empty?
        # create day after for this user
        d = Day.new
        d.day = @day.day + 86400
        d.user_id = @current_user.id
        d.save
      end
      second_days_array = @current_user.days.where("day = ? AND user_id = ?", day_after, @current_user.id)
      @day_after = second_days_array[0]
      @day_id = @day.id
      @user_id = @current_user.id
      @entries = @current_user.entries.where("day_id = ?", @day_id).order("time")
      @entry = Entry.new
      @all_meals = @current_user.meals.order("name")
      @all_foods = Food.all
      @all_ingredients = Ingredient.all
      @symptom = Symptom.new
      @symptoms = @current_user.symptoms.where("day_id = ?", @day_id).order("start_time")
    end
  end

  def summary
    @day = Day.find(params[:id])
    @day_id = @day.id
    return_obj = @current_user.entries.where("day_id = ?", @day_id).order("time").as_json(include: { meals: {
        only: [:name],
        include: { foods: {
          only: [:name],
          include: { ingredients: {
            only: [:name]
            }}
          }}
        }}
      )
    render :json => return_obj.as_json, :status => :ok
  end


  private

  def day_params
    params.permit(:day, :user_id)
  end


end
