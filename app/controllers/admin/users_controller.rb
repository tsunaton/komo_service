class Admin::UsersController < Admin::ApplicationController

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
  end

  def update
    @user = User.find(params[:id])
    case @user.user_type
    when "unauthenticated"
      if @user.update(user_params.merge(user_type: "staff"))
        NoticeCompleteAuthenticationMailer.send_mail(@user).deliver_later
        redirect_to admin_users_path, notice: "新しいスタッフを登録しました"
      else
        flash.now[:alert] = "登録に失敗しました"
        render :staff_authentication
      end
    when "staff"
      if @user.update(user_params)
        redirect_to admin_users_path, notice: "修正しました"
      else
        flash.now[:alert] = "修正に失敗しました"
        render :edit
      end
    end
  end

  def destroy
    if User.find(params[:id]).destroy
      redirect_to admin_home_path, notice: "スタッフを削除しました"
    else
      flash.now[:alert] = "削除に失敗しました"
      render admin_users_path
    end
  end

  def staff_authentication
    @user = User.find(params[:id])
    unless @user.user_type == "unauthenticated"
      redirect_to admin_home_path, notice: "この方は承認済みです"
    end
  end

  private

    def user_params
      params
        .require(:user)
        .permit(:pay_per_hour)
    end

end
