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
    @symptoms = @current_user.symptoms
    @symptom_arr = []
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
    render :json => @symptom_arr.as_json, :status => :ok
  end

  private

  def user_params
    params.permit(:id, :email, :phone, :name, :image, :notifications_preference, known_intolerances: [])
  end

  def make_stats_array(symptom_name)
    arr = ["#{symptom_name}",[]]
    symptoms = @current_user.symptoms.where("name = ?", symptom_name)
    symptoms.each do |s|
      arr[1].push([s.start_time,s.severity])
    end
    if arr[1].length > 0
      @symptom_arr.push(arr)
    end
  end

end
