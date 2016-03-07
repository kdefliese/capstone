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
    @symptoms = @current_user.symptoms
    @symptom_array = []
    @symptoms.each do |s|
      @symptom_array.push([s.name, s.severity])
    end
  end

  def stats_endpoint
    hardcoded = [[[1,12],[2,5],[3,18],[4,13],[5,7],[6,4],[7,9]],[[1,3],[2,8],[3,10],[4,3],[5,7],[6,6],[7,2]],['Extra','Sun','Mon','Tues','Wed','Thurs','Fri','Sat']]
    render :json => hardcoded.as_json, :status => :ok
  end

  private

  def user_params
    params.permit(:id, :email, :phone, :name, :image, :notifications_preference, known_intolerances: [])
  end

end
