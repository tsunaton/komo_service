module SessionsHelper

  def current_user
    if user_id = session[:user_id]
      @current_user ||= User.find_by(id: user_id)
    elsif user_id = cookies.signed[:user_id]
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  def logged_out_user
    if @current_user == nil
      redirect_to root_path, alert: "ログインをお願いいたします"
    end
  end

  def logged_in_user
    if @current_user
      judge_user(@current_user)
    end
  end

  def judge_user(user)
    case user.user_type
    when 'admin'
      redirect_to admin_home_path, notice: "すでにログインしています"
    when 'staff'
      redirect_to staff_home_path, notice: "すでにログインしています"
    end
  end
  # どこのページからリクエストが来たか保存しておく
  def set_request_from
    if session[:request_from]
      @request_from = session[:request_from]
    end
    # 現在のURLをsession[:request_from]に保存しておく
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

  def log_in(user)
    session[:user_id] = user.id
    remember user
  end

  def log_out
    forget(@current_user)
    session.delete(:user_id)
    @current_user = nil
  end

  def admin_user
    unless @current_user.user_type == "admin"
      redirect_to root_path, notice: "管理者ではありません"
    end
  end

  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

end
