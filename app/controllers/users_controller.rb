class UsersController < ApplicationController
  before_action :current_user

  def show
    @user = @current_user
  end

  def edit
    @user = @current_user
  end

  def update
    # need to do something with the three array fields here so they'll update properly
    @user = User.update(params[:id], user_params)
    if @user.save
      redirect_to user_path
    else
      render :edit
    end
  end

  def stats
  end

  private

  def user_params
    params.require(:user).permit(:email, :phone, :name, :image, :known_intolerances, :watching, :medical_disorders, :notifications_preference)
  end

end
