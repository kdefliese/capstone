class UsersController < ApplicationController
  before_action :current_user

  def show
    @user = @current_user
  end

  def edit
  end

  def update
  end

  def stats
  end

end
