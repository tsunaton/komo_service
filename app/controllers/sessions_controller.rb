class SessionsController < ApplicationController
  skip_before_action :logged_out_user, only: [:new, :create]
  before_action :logged_in_user, only: [:new, :create]

  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password]) && user.user_type != "unauthenticated"
      log_in(user)
      remember(user)
      case user.user_type
      when "admin"
        redirect_to admin_home_path, notice: "ログインしました"
      when "staff"
        redirect_to staff_home_path, notice: "ログインしました"
      end
    else
      flash.now[:alert] = "ログインに失敗しました"
      render :new
    end
  end

  def destroy
    log_out
    redirect_to root_path, notice: "ログアウトしました"
  end

end
