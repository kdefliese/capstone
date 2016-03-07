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
    pain = ["Pain",[]]
    gas = ["Gas",[]]
    @symptoms.each do |s|
      if s.name == "Pain"
        pain[1].push([s.start_time,s.severity])
      elsif s.name == "Gas"
        gas[1].push([s.start_time,s.severity])
      end
    end
    @symptom_arr.push(pain)
    @symptom_arr.push(gas)
    render :json => @symptom_arr.as_json, :status => :ok
  end

  private

  def user_params
    params.permit(:id, :email, :phone, :name, :image, :notifications_preference, known_intolerances: [])
  end

end
