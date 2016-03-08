class UsersController < ApplicationController
  before_action :current_user
  before_action :current_day_for_user

  def show
    @user = @current_user
  end

  def edit
    @user = @current_user
  end

  def update
    # need to do something with the three array fields here so they'll update properly
    binding.pry
    @user = User.update(params[:id], user_params)
    redirect_to user_path
  end

  def stats
  end

  def stats_endpoint
    @symptom_arr = []
    @symptom_arr_alt = []
    make_stats_array("Pain")
    make_stats_array("Gas")
    make_stats_array("Diarrhea")
    make_stats_array("Constipation")
    make_stats_array("Headache/Migraine")
    make_stats_array("Bloating")
    make_stats_array("Nausea")
    make_stats_array("Heartburn")
    make_stats_array("Burping")
    make_stats_array("Skin problems")
    render :json => @symptom_arr_alt.as_json, :status => :ok
  end

  private

  def user_params
    params.permit(:id, :email, :phone, :name, :image, :notifications_preference, known_intolerances: [])
  end

  def make_stats_array(symptom_name)
    end_of_day_range = @today - 6
    arr = ["#{symptom_name}",[]]
    arr_alt = ["#{symptom_name}",[]]
    symptoms = @current_user.symptoms.where("name = ? AND start_time >= ?", symptom_name, end_of_day_range).order("start_time")
    symptoms.each do |s|
      arr[1].push([s.start_time.strftime("%m/%d/%Y"),s.severity,s.id])
      obj = {}
      obj[:x] = s.start_time.strftime("%m/%d/%Y")
      obj[:y] = s.severity
      obj[:id] = s.id
      arr_alt[1].push(obj)
    end
    if arr[1].length > 0
      @symptom_arr.push(arr)
    end
    if arr_alt[1].length > 0
      @symptom_arr_alt.push(arr_alt)
    end
  end

end
