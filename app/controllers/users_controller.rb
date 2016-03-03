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

  private

  def user_params
    params.permit(:id, :email, :phone, :name, :image, :notifications_preference, known_intolerances: [])
  end

end
