class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def check_user_login
    if session[:user_id]
      @current_user = User.find(session[:user_id])
    else
      redirect_to login_path, notice: 'Please signup or login before making an art submission'
    end
  end
end
