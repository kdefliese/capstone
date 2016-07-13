class DaysController < ApplicationController
  before_action :current_user
  before_action :current_day_for_user

  def show
    # an oops page would probably be better than redirecting to current day if day doesn't exist...
    @day = Day.find_by id: params[:id]
    if @day.nil?
      redirect_to day_path(@current_day.id)
    end
    if !@day.nil?
      # is this the best behavior if the day doesn't belong to the current user?
      if @day.user_id != @current_user.id
        redirect_to day_path(@current_day.id)
      else
        find_or_create_previous_day
        find_or_create_next_day
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

  def find_or_create_previous_day
    day_before = @day.day - 86400
    check_day_before = @current_user.days.where("day = ? AND user_id = ?", day_before, @current_user.id)
    if check_day_before.empty?
      @day.create_day_before(@current_user.id)
    end
    @day_before = @current_user.days.where("day = ? AND user_id = ?", day_before, @current_user.id).first
  end

  def find_or_create_next_day
    day_after = @day.day + 86400
    check_day_after = @current_user.days.where("day = ? AND user_id = ?", day_after, @current_user.id)
    if check_day_after.empty?
      @day.create_day_after(@current_user.id)
    end
    @day_after = @current_user.days.where("day = ? AND user_id = ?", day_after, @current_user.id).first
  end

end
