module SessionsHelper

  # どこのページからリクエストが来たか保存しておく
  def set_request_from
    if session[:request_from]
      @request_from = session[:request_from]
    end
    # 現在のURLを保存しておく
    session[:request_from] = request.original_url
  end

  # 前の画面に戻る
  def return_back
    if request.referer
      redirect_to :back
    elsif @request_from
      redirect_to @request_from
    end
  end

  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  def log_in(user)
    session[:user_id] = user.id
  end

  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  def log_out
    forget(@current_user)
    session.delete(:user_id)
    @current_user = nil
  end

  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  def logged_in?
   !@current_user.nil?
  end

  def logged_in_user
    unless logged_in? || controller_path.include?("session") || controller_path.include?("users") && action_name.include?("new") || action_name.include?("apply_for_authentication")
      flash[:danger] = "Please log in."
      redirect_to root_path
    end
  end

  def logged_out_user
    if @current_user
      flash[:danger] = "you've already logged in."
      return_back
    end
  end

  def admin_user
    return_back unless @current_user.user_type == "admin"
  end

end
