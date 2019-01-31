class ApplicationController < ActionController::Base

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def log_in?
    !current_user.nil?
  end


  def logged_in_user
    unless log_in?
      flash[:danger] = "Please log in."
      redirect_to login_path
    end
  end
  
end
