class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def require_login
    unless current_user
      flash[:error] = "Please log in to view this section."
      redirect_to login_path
    end
  end

  def current_day_for_user
    @today = Date.today
    @current_day = Day.where("day = ? AND user_id = ?", @today, @current_user.id).first
  end

end
