class SessionsController < ApplicationController
  before_action :logged_out_user, only: [:new, :create]

  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password]) && user.user_type != "unauthenticated"
      log_in(user)
      remember(user)
      case user.user_type
      when "admin"
        redirect_to admin_home_path
      when "staff"
        redirect_to staff_home_path
      end
    else
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_path
  end

end
