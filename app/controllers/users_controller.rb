class UsersController < ApplicationController
  before_action :current_user

  def show
    @user = @current_user
  end

  def edit
    @user = @current_user
  end

  def update
    # @current_user.update(
    # name: user_params[:user][:name],
    # email: user_params[:user][:email],
    # phone: user_params[:user][:phone],
    # image: user_params[:user][:image],
    # known_intolerances: user_params[:user][:known_intolerances],
    # watching: user_params[:user][:watching],
    # medical_disorders: user_params[:user][:medical_disorders],
    # notifications_preference: user_params[:user][:notifications_preferences]
    # )
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
